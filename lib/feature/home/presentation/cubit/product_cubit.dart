import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:rental_hub/feature/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/remove_favorite_use_case.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_products.dart';
import 'package:rental_hub/core/utils/favorite_state_manager.dart';
import 'dart:developer' as developer;

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final GetProducts _getProducts;
  final AddToFavoriteUseCase _addToFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final FavoriteStateManager _favoriteStateManager;

  late final PagingController<int, ProductEntity> pagingController;

  ProductCubit(
    this._getProducts,
    this._addToFavoriteUseCase,
    this._removeFavoriteUseCase,
    this._favoriteStateManager,
  ) : super(ProductInitial()) {
    _favoriteStateManager.notifier.addListener(_onFavoritesChanged);
    _initializePagingController();
  }

  @override
  void onChange(Change<ProductState> change) {
    super.onChange(change);
    developer.log(
      'Cubit state transition: ${change.currentState.runtimeType} -> ${change.nextState.runtimeType}',
      name: 'Instrumentation',
    );
    if (change.nextState is ProductLoaded) {
      developer.log(
        'Cubit count: ${(change.nextState as ProductLoaded).products.items.length}',
        name: 'Instrumentation',
      );
    }
  }

  void _initializePagingController() {
    pagingController = PagingController<int, ProductEntity>(
      getNextPageKey: (state) {
        if (state.keys == null || state.keys!.isEmpty) return 1;
        if (state.lastPageIsEmpty) return null;
        final lastKey = state.keys!.last;
        return lastKey + 1;
      },
      fetchPage: (pageKey) async {
        developer.log(
          'PagingController count start fetchPage $pageKey',
          name: 'Instrumentation',
        );
        try {
          final result = await _getProducts(pageKey);
          return result.fold(
            (failure) {
              developer.log(
                'PagingController count fetchPage error: ${failure.errMessage}',
                name: 'Instrumentation',
              );
              _handleError(failure.errMessage);
              throw Exception(failure.errMessage);
            },
            (response) {
              developer.log(
                'PagingController count success: ${response.items.length}',
                name: 'Instrumentation',
              );
              final sortedItems = List<ProductEntity>.from(response.items)
                ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
              final overriddenItems = sortedItems.map((product) {
                final managerFav =
                    _favoriteStateManager.contains(product.id);
                if (managerFav != product.isFavorite) {
                  return product.copyWith(isFavorite: managerFav);
                }
                return product;
              }).toList();
              final sortedResponse = response.copyWith(items: overriddenItems);
              if (pageKey == 1) {
                emit(ProductLoaded(sortedResponse));
              }
              return sortedItems;
            },
          );
        } catch (e) {
          developer.log(
            'PagingController count fetchPage catch error: $e',
            name: 'Instrumentation',
          );
          _handleError(e.toString());
          rethrow;
        }
      },
    );

    pagingController.addListener(_syncLoadedProductsFromPagingController);
  }

  void _handleError(String message) {
    try {
      emit(ProductError(message: message));
    } catch (_) {}
  }

  void _syncLoadedProductsFromPagingController() {
    final currentState = state;
    if (currentState is! ProductLoaded) return;

    final items = pagingController.items;
    if (items == null) return;

    final syncedItems = items.map((product) {
      final managerFav = _favoriteStateManager.contains(product.id);
      if (managerFav != product.isFavorite) {
        return product.copyWith(isFavorite: managerFav);
      }
      return product;
    }).toList(growable: false);

    final syncedProducts = currentState.products.copyWith(
      items: syncedItems,
    );

    if (_areProductsEqual(currentState.products.items, syncedProducts.items)) {
      return;
    }

    emit(
      ProductLoaded(
        syncedProducts,
        favoriteLoadingProductIds: currentState.favoriteLoadingProductIds,
      ),
    );
  }

  void _onFavoritesChanged() {
    final currentState = state;
    if (currentState is! ProductLoaded) return;

    final updatedItems = currentState.products.items.map((product) {
      final managerFav = _favoriteStateManager.contains(product.id);
      if (managerFav != product.isFavorite) {
        return product.copyWith(isFavorite: managerFav);
      }
      return product;
    }).toList(growable: false);

    if (_areProductsEqual(currentState.products.items, updatedItems)) return;

    emit(ProductLoaded(
      currentState.products.copyWith(items: updatedItems),
      favoriteLoadingProductIds: currentState.favoriteLoadingProductIds,
    ));
  }

  bool _areProductsEqual(
    List<ProductEntity> first,
    List<ProductEntity> second,
  ) {
    if (first.length != second.length) return false;

    for (var index = 0; index < first.length; index++) {
      final left = first[index];
      final right = second[index];
      if (left.id != right.id || left.isFavorite != right.isFavorite) {
        return false;
      }
    }

    return true;
  }

  Future<void> toggleFavorite(int productId) async {
    final currentState = state;
    if (currentState is! ProductLoaded) return;
    if (currentState.isFavoriteLoading(productId)) return;

    final targetProduct = _findProduct(productId, currentState.products);
    if (targetProduct == null) return;

    final toggledFavorite = !targetProduct.isFavorite;
    final optimisticProducts = _updateProductsEntity(
      currentState.products,
      productId: productId,
      isFavorite: toggledFavorite,
    );

    final optimisticLoadingIds = Set<int>.from(
      currentState.favoriteLoadingProductIds,
    )..add(productId);

    _applyFavoriteUpdate(
      products: optimisticProducts,
      favoriteLoadingProductIds: optimisticLoadingIds,
    );

    final result = toggledFavorite
        ? await _addToFavoriteUseCase(productId: productId)
        : await _removeFavoriteUseCase(productId: productId);

    result.fold(
      (failure) {
        final rollbackProducts = _updateProductsEntity(
          currentState.products,
          productId: productId,
          isFavorite: targetProduct.isFavorite,
        );
        final rollbackLoadingIds = Set<int>.from(optimisticLoadingIds)
          ..remove(productId);
        _applyFavoriteUpdate(
          products: rollbackProducts,
          favoriteLoadingProductIds: rollbackLoadingIds,
        );
      },
      (_) {
        if (toggledFavorite) {
          _favoriteStateManager.add(productId);
        } else {
          _favoriteStateManager.remove(productId);
        }
        final successLoadingIds = Set<int>.from(optimisticLoadingIds)
          ..remove(productId);
        _applyFavoriteUpdate(
          products: _updateProductsEntity(
            currentState.products,
            productId: productId,
            isFavorite: toggledFavorite,
          ),
          favoriteLoadingProductIds: successLoadingIds,
        );
      },
    );
  }

  void _applyFavoriteUpdate({
    required ProductsEntity products,
    required Set<int> favoriteLoadingProductIds,
  }) {
    pagingController.mapItems((product) {
      return products.items.firstWhere(
        (item) => item.id == product.id,
        orElse: () => product,
      );
    });
    emit(
      ProductLoaded(
        products,
        favoriteLoadingProductIds: favoriteLoadingProductIds,
      ),
    );
  }

  ProductsEntity _updateProductsEntity(
    ProductsEntity products, {
    required int productId,
    required bool isFavorite,
  }) {
    final updatedItems = products.items
        .map(
          (product) => product.id == productId
              ? product.copyWith(isFavorite: isFavorite)
              : product,
        )
        .toList(growable: false);

    return products.copyWith(items: updatedItems);
  }

  ProductEntity? _findProduct(int productId, ProductsEntity products) {
    for (final product in products.items) {
      if (product.id == productId) {
        return product;
      }
    }
    return null;
  }

  Future<void> fetchProducts({int pageNumber = 1}) async {
    if (pageNumber == 1) {
      emit(ProductLoading());
      pagingController.refresh();
      pagingController.fetchNextPage();
    } else {
      pagingController.fetchNextPage();
    }
  }

  void refresh() {
    pagingController.refresh();
    pagingController.fetchNextPage();
    emit(ProductLoading());
  }

  @override
  Future<void> close() {
    _favoriteStateManager.notifier.removeListener(_onFavoritesChanged);
    pagingController.dispose();
    return super.close();
  }
}
