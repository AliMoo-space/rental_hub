import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';
import 'package:rental_hub/feature/product_details/domain/usecases/product_details_use_case.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  final ProductDetailsUseCase useCase;
  ProductDetailsCubit(this.useCase) : super(ProductDetailsInitial());

  Future<void> fetchProductDetails(int id) async {
    emit(ProductDetailsLoading());
    final result = await useCase(id);
    result.fold(
      (failure) => emit(ProductDetailsError(failure.errMessage)),
      (productDetails) => emit(ProductDetailsLoaded(productDetails)),
    );
  }
}
