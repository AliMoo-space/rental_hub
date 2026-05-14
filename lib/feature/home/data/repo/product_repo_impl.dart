import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/data/datasource/product_remote_data_source_imp.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/product_repo.dart';

class ProductRepoImpl implements ProductRepo {
  final ProductRemoteDataSourceImp remoteDataSource;

  ProductRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductsEntity>> getProducts({
    required int pageNumber,
  }) async {
    try {
      final products = await remoteDataSource.getProducts(
        pageNumber: pageNumber,
      );
      return Right(products);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل تحميل المنتجات: ${e.toString()}'));
    }
  }
}
