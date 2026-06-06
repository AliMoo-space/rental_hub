import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

sealed class MyProductsState extends Equatable {
  const MyProductsState();

  @override
  List<Object?> get props => [];
}

final class MyProductsInitial extends MyProductsState {
  const MyProductsInitial();
}

final class MyProductsLoading extends MyProductsState {
  const MyProductsLoading();
}

final class MyProductsLoaded extends MyProductsState {
  final ProductsEntity products;

  const MyProductsLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

final class MyProductsError extends MyProductsState {
  final String message;

  const MyProductsError(this.message);

  @override
  List<Object?> get props => [message];
}
