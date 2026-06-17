import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/usecases/get_recommendations_usecase.dart';
import 'package:rental_hub/feature/search/domain/usecases/live_search_usecase.dart';
import 'package:rental_hub/feature/search/domain/usecases/search_products_usecase.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final LiveSearchUseCase liveSearchUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final GetRecommendationsUseCase getRecommendationsUseCase;

  Timer? _debounce;
  CancelToken? _cancelToken;

  String currentQuery = '';
  int pageNumber = 1;

  SearchCubit(
    this.liveSearchUseCase,
    this.searchProductsUseCase,
    this.getRecommendationsUseCase,
  ) : super(SearchInitial());

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
    res.fold(
      (f) => emit(SearchError(f.errMessage)),
      (results) {
        if (results.items.isEmpty) return emit(SearchEmpty());
        emit(SearchLoaded(results, false));
      },
    );
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
      final hasMore =
          results.items.length >= results.pageSize &&
          results.totalCount > results.items.length * results.pageNumber;
      emit(SearchLoaded(results, hasMore));
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
        pageNumber -= 1; // Rollback page number on error
        emit(SearchError(f.errMessage));
      },
      (results) {
        final merged = SearchResultEntity(
          items: [...previousState.results.items, ...results.items],
          totalCount: results.totalCount,
          pageNumber: results.pageNumber,
          pageSize: results.pageSize,
        );
        final hasMore = merged.items.length < results.totalCount;
        emit(SearchLoaded(merged, hasMore));
      },
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _cancelToken?.cancel();
    return super.close();
  }
}
