import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rental_hub/core/utils/favorite_state_manager.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/remove_favorite_use_case.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/usecases/get_recommendations_usecase.dart';
import 'package:rental_hub/feature/search/domain/usecases/live_search_usecase.dart';
import 'package:rental_hub/feature/search/domain/usecases/search_products_usecase.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final LiveSearchUseCase liveSearchUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetRecommendationsUseCase getRecommendationsUseCase;
  final AddToFavoriteUseCase _addToFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final FavoriteStateManager _favoriteStateManager;

  Timer? _debounce;
  CancelToken? _cancelToken;

  String currentQuery = '';
  int pageNumber = 1;

  SearchCubit(
    this.liveSearchUseCase,
    this.searchProductsUseCase,
    this.getRecommendationsUseCase,
    this._addToFavoriteUseCase,
    this._removeFavoriteUseCase,
    this._favoriteStateManager,
  ) : super(SearchInitial()) {
    _favoriteStateManager.notifier.addListener(_onFavoritesChanged);
  }

  SearchResultEntity _applyFavoriteOverride(SearchResultEntity results) {
    final overriddenItems = results.items.map((item) {
      final managerFav = _favoriteStateManager.contains(item.id);
      if (managerFav != item.isFavorite) {
        return ProductItemEntity(
          id: item.id,
          name: item.name,
          category: item.category,
          basePricePerDay: item.basePricePerDay,
          location: item.location,
          condition: item.condition,
          images: item.images,
          rating: item.rating,
          createdAt: item.createdAt,
          isFavorite: managerFav,
        );
      }
      return item;
    }).toList();

    return SearchResultEntity(
      items: overriddenItems,
      totalCount: results.totalCount,
      pageNumber: results.pageNumber,
      pageSize: results.pageSize,
    );
  }

  void _onFavoritesChanged() {
    final currentState = state;
    if (currentState is! SearchLoaded) return;
    final overridden = _applyFavoriteOverride(currentState.results);
    final hasMore = currentState.hasMore;
    final loadingIds = currentState.favoriteLoadingProductIds;
    emit(SearchLoaded(overridden, hasMore,
        favoriteLoadingProductIds: loadingIds));
  }

  void onQueryChanged(String q) {
    currentQuery = q;
    _cancelToken?.cancel();
    _cancelToken = CancelToken();

    _debounce?.cancel();
    if (q.trim().isEmpty) {
      loadRecommendations();
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      emit(LiveSearchLoading());
      final res = await liveSearchUseCase.call(q);
      res.fold((f) => emit(SearchError(f.errMessage)), (suggestions) {
        emit(LiveSearchLoaded(suggestions));
      });
    });
  }

  Future<void> loadRecommendations() async {
    emit(SearchLoading());
    final res = await getRecommendationsUseCase.call();
    res.fold((f) => emit(SearchError(f.errMessage)), (results) {
      if (results.items.isEmpty) return emit(SearchEmpty());
      emit(SearchLoaded(_applyFavoriteOverride(results), false));
    });
  }

  Future<void> submitSearch({bool reset = true}) async {
    if (state is SearchLoading) return;
    if (currentQuery.trim().isEmpty) {
      await loadRecommendations();
      return;
    }
    if (reset) pageNumber = 1;
    emit(SearchLoading());
    final res = await searchProductsUseCase.call(
      query: currentQuery,
      pageNumber: pageNumber,
    );

    res.fold((f) => emit(SearchError(f.errMessage)), (results) {
      if (results.items.isEmpty) return emit(SearchEmpty());
      final sortedItems = List<ProductItemEntity>.from(results.items)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
      final sortedResults = SearchResultEntity(
        items: sortedItems,
        totalCount: results.totalCount,
        pageNumber: results.pageNumber,
        pageSize: results.pageSize,
      );
      final hasMore =
          sortedItems.length >= results.pageSize &&
          results.totalCount > sortedItems.length * results.pageNumber;
      emit(SearchLoaded(_applyFavoriteOverride(sortedResults), hasMore));
    });
  }

  Future<void> loadMore() async {
    if (state is! SearchLoaded || state is SearchLoadingMore) return;
    final previousState = state as SearchLoaded;
    pageNumber += 1;
    emit(SearchLoadingMore());
    final res = await searchProductsUseCase.call(
      query: currentQuery,
      pageNumber: pageNumber,
    );
    res.fold(
      (f) {
        pageNumber -= 1;
        emit(SearchError(f.errMessage));
      },
      (results) {
        final mergedItems = [...previousState.results.items, ...results.items]
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        final merged = SearchResultEntity(
          items: mergedItems,
          totalCount: results.totalCount,
          pageNumber: results.pageNumber,
          pageSize: results.pageSize,
        );
        final hasMore = merged.items.length < results.totalCount;
        emit(SearchLoaded(_applyFavoriteOverride(merged), hasMore,
            favoriteLoadingProductIds:
                previousState.favoriteLoadingProductIds));
      },
    );
  }

  Future<void> toggleFavorite(int productId) async {
    final currentState = state;
    if (currentState is! SearchLoaded) return;
    if (currentState.isFavoriteLoading(productId)) return;

    final targetItem = currentState.results.items
        .where((item) => item.id == productId)
        .firstOrNull;
    if (targetItem == null) return;

    final toggledFavorite = !targetItem.isFavorite;

    final optimisticLoadingIds = Set<int>.from(
      currentState.favoriteLoadingProductIds,
    )..add(productId);

    final optimisticItems = currentState.results.items.map((item) {
      if (item.id == productId) {
        return ProductItemEntity(
          id: item.id,
          name: item.name,
          category: item.category,
          basePricePerDay: item.basePricePerDay,
          location: item.location,
          condition: item.condition,
          images: item.images,
          rating: item.rating,
          createdAt: item.createdAt,
          isFavorite: toggledFavorite,
        );
      }
      return item;
    }).toList();

    final optimisticResults = SearchResultEntity(
      items: optimisticItems,
      totalCount: currentState.results.totalCount,
      pageNumber: currentState.results.pageNumber,
      pageSize: currentState.results.pageSize,
    );

    emit(SearchLoaded(optimisticResults, currentState.hasMore,
        favoriteLoadingProductIds: optimisticLoadingIds));

    final result = toggledFavorite
        ? await _addToFavoriteUseCase(productId: productId)
        : await _removeFavoriteUseCase(productId: productId);

    result.fold(
      (failure) {
        final rollbackLoadingIds = Set<int>.from(optimisticLoadingIds)
          ..remove(productId);
        emit(SearchLoaded(
            _applyFavoriteOverride(currentState.results), currentState.hasMore,
            favoriteLoadingProductIds: rollbackLoadingIds));
      },
      (_) {
        if (toggledFavorite) {
          _favoriteStateManager.add(productId);
        } else {
          _favoriteStateManager.remove(productId);
        }
        final successLoadingIds = Set<int>.from(optimisticLoadingIds)
          ..remove(productId);
        emit(SearchLoaded(optimisticResults, currentState.hasMore,
            favoriteLoadingProductIds: successLoadingIds));
      },
    );
  }

  @override
  Future<void> close() {
    _favoriteStateManager.notifier.removeListener(_onFavoritesChanged);
    _debounce?.cancel();
    _cancelToken?.cancel();
    return super.close();
  }
}
