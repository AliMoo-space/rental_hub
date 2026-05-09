import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/product_repo.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepo _repo;

  ProductCubit(this._repo) : super(ProductInitial());

  Future<void> fetchProducts() async {
    emit(ProductLoading());
    final result = await _repo.getProducts();
    result.fold(
      (failure) => emit(ProductError(message: failure.errMessage)),
      (products) => emit(ProductLoaded(products)),
    );
  }
}
