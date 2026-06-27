import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:rental_hub/core/utils/favorite_state_manager.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/add_to_favorite_usecase.dart';
import 'package:rental_hub/feature/favorites/domain/usecase/remove_favorite_use_case.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';
import 'package:rental_hub/feature/product_details/domain/usecases/product_details_use_case.dart';
import 'dart:developer' as developer;

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsUseCase _useCase;
  final AddToFavoriteUseCase _addToFavoriteUseCase;
  final RemoveFavoriteUseCase _removeFavoriteUseCase;
  final FavoriteStateManager _favoriteStateManager;

  ProductDetailsCubit({
    required ProductDetailsUseCase useCase,
    required AddToFavoriteUseCase addToFavoriteUseCase,
    required RemoveFavoriteUseCase removeFavoriteUseCase,
    required FavoriteStateManager favoriteStateManager,
  }) : _useCase = useCase,
       _addToFavoriteUseCase = addToFavoriteUseCase,
       _removeFavoriteUseCase = removeFavoriteUseCase,
       _favoriteStateManager = favoriteStateManager,
       super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int id) async {
    emit(ProductDetailsLoading());
    final result = await _useCase(id);
    result.fold((failure) => emit(ProductDetailsError(failure.errMessage)), (
      productDetails,
    ) {
      developer.log(
        'ProductDetailsCubit: loaded product location: ${productDetails.locationArea}',
        name: 'ProductDetails',
      );
      final overriddenFav = _favoriteStateManager.contains(id);
      final finalDetails = overriddenFav != productDetails.isFavorite
          ? ProductDetailsEntity(
              id: productDetails.id,
              name: productDetails.name,
              description: productDetails.description,
              condition: productDetails.condition,
              status: productDetails.status,
              rejectionReason: productDetails.rejectionReason,
              basePricePerDay: productDetails.basePricePerDay,
              finalPricePerDay: productDetails.finalPricePerDay,
              commissionPercentage: productDetails.commissionPercentage,
              locationArea: productDetails.locationArea,
              productType: productDetails.productType,
              brand: productDetails.brand,
              rentalGuarantee: productDetails.rentalGuarantee,
              termsConditions: productDetails.termsConditions,
              createdAt: productDetails.createdAt,
              updatedAt: productDetails.updatedAt,
              averageRating: productDetails.averageRating,
              totalReviews: productDetails.totalReviews,
              totalRentalCount: productDetails.totalRentalCount,
              totalPlatformProfit: productDetails.totalPlatformProfit,
              ownerId: productDetails.ownerId,
              ownerName: productDetails.ownerName,
              ownerEmail: productDetails.ownerEmail,
              ownerPhone: productDetails.ownerPhone,
              categoryId: productDetails.categoryId,
              categoryName: productDetails.categoryName,
              subcategoryId: productDetails.subcategoryId,
              subcategoryName: productDetails.subcategoryName,
              images: productDetails.images,
              isFavorite: overriddenFav,
            )
          : productDetails;
      emit(ProductDetailsLoaded(finalDetails));
    });
  }

  Future<void> toggleFavorite(int productId) async {
    final currentState = state;
    if (currentState is! ProductDetailsLoaded) return;
    if (currentState.isFavoriteLoading(productId)) return;

    final toggledFavorite = !currentState.productDetails.isFavorite;

    final updatedDetails = ProductDetailsEntity(
      id: currentState.productDetails.id,
      name: currentState.productDetails.name,
      description: currentState.productDetails.description,
      condition: currentState.productDetails.condition,
      status: currentState.productDetails.status,
      rejectionReason: currentState.productDetails.rejectionReason,
      basePricePerDay: currentState.productDetails.basePricePerDay,
      finalPricePerDay: currentState.productDetails.finalPricePerDay,
      commissionPercentage: currentState.productDetails.commissionPercentage,
      locationArea: currentState.productDetails.locationArea,
      productType: currentState.productDetails.productType,
      brand: currentState.productDetails.brand,
      rentalGuarantee: currentState.productDetails.rentalGuarantee,
      termsConditions: currentState.productDetails.termsConditions,
      createdAt: currentState.productDetails.createdAt,
      updatedAt: currentState.productDetails.updatedAt,
      averageRating: currentState.productDetails.averageRating,
      totalReviews: currentState.productDetails.totalReviews,
      totalRentalCount: currentState.productDetails.totalRentalCount,
      totalPlatformProfit: currentState.productDetails.totalPlatformProfit,
      ownerId: currentState.productDetails.ownerId,
      ownerName: currentState.productDetails.ownerName,
      ownerEmail: currentState.productDetails.ownerEmail,
      ownerPhone: currentState.productDetails.ownerPhone,
      categoryId: currentState.productDetails.categoryId,
      categoryName: currentState.productDetails.categoryName,
      subcategoryId: currentState.productDetails.subcategoryId,
      subcategoryName: currentState.productDetails.subcategoryName,
      images: currentState.productDetails.images,
      isFavorite: toggledFavorite,
    );

    final optimisticLoadingIds = Set<int>.from(
      currentState.favoriteLoadingProductIds,
    )..add(productId);

    emit(
      ProductDetailsLoaded(
        updatedDetails,
        favoriteLoadingProductIds: optimisticLoadingIds,
      ),
    );

    final result = toggledFavorite
        ? await _addToFavoriteUseCase(productId: productId)
        : await _removeFavoriteUseCase(productId: productId);

    result.fold(
      (failure) {
        _favoriteStateManager.toggle(productId);
        emit(
          ProductDetailsLoaded(
            currentState.productDetails,
            favoriteLoadingProductIds: Set<int>.from(optimisticLoadingIds)
              ..remove(productId),
          ),
        );
      },
      (response) {
        if (toggledFavorite) {
          _favoriteStateManager.add(productId);
        } else {
          _favoriteStateManager.remove(productId);
        }
        emit(
          ProductDetailsLoaded(
            updatedDetails,
            favoriteLoadingProductIds: Set<int>.from(optimisticLoadingIds)
              ..remove(productId),
          ),
        );
      },
    );
  }
}
