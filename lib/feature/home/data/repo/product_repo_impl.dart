import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/product_repo.dart';
import 'dart:developer' as developer;

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductsEntity>> getProducts({
    required int pageNumber,
  }) async {
    developer.log('Repository count start', name: 'Instrumentation');
    try {
      final products = await remoteDataSource.getProducts(
        pageNumber: pageNumber,
      );
      developer.log('Repository count success: ${products.items.length}', name: 'Instrumentation');
      return Right(products);
    } on ServerException catch (e) {
      developer.log('Repository count error ServerException: ${e.errorModel.firstErrorMessage}', name: 'Instrumentation');
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      developer.log('Repository count error Exception: $e', name: 'Instrumentation');
      return Left(Failure(errMessage: 'فشل تحميل المنتجات: ${e.toString()}'));
    }
  }
}
