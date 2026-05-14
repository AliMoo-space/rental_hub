part of 'product_cubit.dart';

sealed class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductLoaded extends ProductState {
  final ProductsEntity products;
  final Set<int> favoriteLoadingProductIds;

  const ProductLoaded(
    this.products, {
    this.favoriteLoadingProductIds = const {},
  });

  bool isFavoriteLoading(int productId) =>
      favoriteLoadingProductIds.contains(productId);

  @override
  List<Object> get props => [products, favoriteLoadingProductIds];
}

final class ProductError extends ProductState {
  final String message;
  const ProductError({required this.message});

  @override
  List<Object> get props => [message];
}
