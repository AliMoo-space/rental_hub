import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:rental_hub/feature/favorites/data/model/favorites_item_model.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/get_favorite_usecase.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  static const int _firstPageKey = 1;

  final GetFavorites _getFavorites;

  late final PagingController<int, FavoriteItemModel> pagingController;

  int? _totalPages;

  FavoriteCubit({required GetFavorites getFavorites})
    : _getFavorites = getFavorites,
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
        }

        favoriteProductIds.addAll(response.items.map((e) => e.productId));

        emit(GetFavoritesSuccess());

        return response.items;
      },
    );
  }

  bool isFavorite(int productId) {
    return favoriteProductIds.contains(productId);
  }

  @override
  Future<void> close() {
    pagingController.dispose();

    return super.close();
  }
}
