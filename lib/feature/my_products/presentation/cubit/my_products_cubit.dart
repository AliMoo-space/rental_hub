import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/activate_product_use_case.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/delete_product_use_case.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/get_my_products.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/suspend_product_use_case.dart';

import 'my_products_state.dart';

class MyProductsCubit extends Cubit<MyProductsState> {
  final GetMyProducts getMyProductsUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  final SuspendProductUseCase suspendProductUseCase;
  final ActivateProductUseCase activateProductUseCase;

  late final PagingController<int, ProductEntity> pagingController;

  MyProductsCubit(
    this.getMyProductsUseCase,
    this.deleteProductUseCase,
    this.suspendProductUseCase,
    this.activateProductUseCase,
  ) : super(const MyProductsInitial()) {
    _initializePagingController();
  }

  void _initializePagingController() {
    pagingController = PagingController<int, ProductEntity>(
      getNextPageKey: (state) {
        if (state.keys == null || state.keys!.isEmpty) {
          return 1;
        }

        final lastKey = state.keys!.last;
        return state.hasNextPage ? lastKey + 1 : null;
      },
      fetchPage: (pageKey) async {
        final result = await getMyProductsUseCase(pageKey);
        return result.fold(
          (failure) {
            emit(MyProductsError(failure.errMessage));
            throw Exception(failure.errMessage);
          },
          (response) {
            if (pageKey == 1) {
              emit(MyProductsLoaded(response));
            }

            return response.items;
          },
        );
      },
    );
  }

  Future<void> loadMyProducts() async {
    emit(const MyProductsLoading());
    pagingController.refresh();
    await Future.delayed(const Duration(milliseconds: 100));
    pagingController.fetchNextPage();
  }

  Future<Either<Failure, String>> deleteProduct({required int id}) async {
    final result = await deleteProductUseCase(id: id);
    return await result.fold<Future<Either<Failure, String>>>(
      (failure) async => Left(failure),
      (message) async {
        await loadMyProducts();
        return Right(message);
      },
    );
  }

  Future<Either<Failure, String>> suspendProduct({required int id}) async {
    final result = await suspendProductUseCase(id: id);
    return await result.fold<Future<Either<Failure, String>>>(
      (failure) async => Left(failure),
      (message) async {
        await loadMyProducts();
        return Right(message);
      },
    );
  }

  Future<Either<Failure, String>> activateProduct({required int id}) async {
    final result = await activateProductUseCase(id: id);
    return await result.fold<Future<Either<Failure, String>>>(
      (failure) async => Left(failure),
      (message) async {
        await loadMyProducts();
        return Right(message);
      },
    );
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }
}
