import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:rental_hub/core/utils/favorite_state_manager.dart';
import 'package:rental_hub/feature/favorites/data/model/favorites_item_model.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/get_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/remove_favorite_use_case.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  static const int _firstPageKey = 1;

  final GetFavorites _getFavorites;
  final AddToFavoriteUseCase _addToFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final FavoriteStateManager _favoriteStateManager;

  late final PagingController<int, FavoriteItemModel> pagingController;

  int? _totalPages;

  FavoriteCubit({
    required GetFavorites getFavorites,
    required AddToFavoriteUseCase addToFavoriteUseCase,
    required RemoveFavoriteUseCase removeFavoriteUseCase,
    required FavoriteStateManager favoriteStateManager,
  })  : _getFavorites = getFavorites,
        _addToFavoriteUseCase = addToFavoriteUseCase,
        _removeFavoriteUseCase = removeFavoriteUseCase,
        _favoriteStateManager = favoriteStateManager,
        super(FavoriteInitial()) {
    _initializePagingController();
  }

  void _initializePagingController() {
    pagingController = PagingController<int, FavoriteItemModel>(
      getNextPageKey: _getNextPageKey,
      fetchPage: _fetchFavoritesPage,
    );
  }

  final Set<int> favoriteProductIds = {};

  int? _getNextPageKey(PagingState<int, FavoriteItemModel> state) {
    final keys = state.keys;

    if (keys == null || keys.isEmpty) {
      return _firstPageKey;
    }

    final lastPageKey = keys.last;

    if (_totalPages != null && lastPageKey >= _totalPages!) {
      return null;
    }

    if (state.lastPageIsEmpty) {
      return null;
    }

    return lastPageKey + 1;
  }

  Future<List<FavoriteItemModel>> _fetchFavoritesPage(int pageKey) async {
    emit(GetFavoritesLoading());

    final result = await _getFavorites(pageKey);

    return result.fold(
      (failure) {
        emit(GetFavoritesError(message: failure.errMessage));
        throw Exception(failure.errMessage);
      },
      (response) {
        _totalPages = response.totalPages;

        if (pageKey == _firstPageKey) {
          favoriteProductIds.clear();
          _favoriteStateManager.clear();
        }

        favoriteProductIds.addAll(response.items.map((e) => e.productId));
        _favoriteStateManager.addAll(
          response.items.map((e) => e.productId),
        );

        final loadingIds = _getCurrentLoadingIds();
        emit(GetFavoritesSuccess(favoriteLoadingProductIds: loadingIds));

        return response.items;
      },
    );
  }

  bool isFavorite(int productId) {
    return favoriteProductIds.contains(productId);
  }

  Set<int> _getCurrentLoadingIds() {
    final state = this.state;
    if (state is GetFavoritesSuccess) {
      return state.favoriteLoadingProductIds;
    }
    return {};
  }

  Future<void> toggleFavorite(int productId) async {
    final currentState = state;
    if (currentState is GetFavoritesSuccess &&
        currentState.isFavoriteLoading(productId)) {
      return;
    }

    final isCurrentlyFav = favoriteProductIds.contains(productId);

    final optimisticLoadingIds = Set<int>.from(
      currentState is GetFavoritesSuccess
          ? currentState.favoriteLoadingProductIds
          : const <int>{},
    )..add(productId);

    if (isCurrentlyFav) {
      favoriteProductIds.remove(productId);
      _favoriteStateManager.remove(productId);
    } else {
      favoriteProductIds.add(productId);
      _favoriteStateManager.add(productId);
    }

    emit(GetFavoritesSuccess(favoriteLoadingProductIds: optimisticLoadingIds));

    final result = isCurrentlyFav
        ? await _removeFavoriteUseCase(productId: productId)
        : await _addToFavoriteUseCase(productId: productId);

    result.fold(
      (failure) {
        if (isCurrentlyFav) {
          favoriteProductIds.add(productId);
          _favoriteStateManager.add(productId);
        } else {
          favoriteProductIds.remove(productId);
          _favoriteStateManager.remove(productId);
        }
        emit(
          GetFavoritesSuccess(
            favoriteLoadingProductIds: Set<int>.from(optimisticLoadingIds)
              ..remove(productId),
          ),
        );
      },
      (_) {
        if (isCurrentlyFav) {
          pagingController.refresh();
        }
        emit(
          GetFavoritesSuccess(
            favoriteLoadingProductIds: Set<int>.from(optimisticLoadingIds)
              ..remove(productId),
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
