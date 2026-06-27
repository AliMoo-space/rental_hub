part of 'product_details_cubit.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductDetailsEntity productDetails;
  final Set<int> favoriteLoadingProductIds;

  const ProductDetailsLoaded(
    this.productDetails, {
    this.favoriteLoadingProductIds = const {},
  });

  bool isFavoriteLoading(int productId) =>
      favoriteLoadingProductIds.contains(productId);

  @override
  List<Object> get props => [productDetails, favoriteLoadingProductIds];
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;

  const ProductDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
