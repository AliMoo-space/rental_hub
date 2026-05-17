import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_details/data/datasource/product_details_remote_data_source.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';
import 'package:rental_hub/feature/product_details/domain/repo/product_details_repo.dart';

class ProductDetailsRepoImpl implements ProductDetailsRepo {
  final ProductDetailsRemoteDataSource remoteDataSource;

  ProductDetailsRepoImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, ProductDetailsEntity>> fetchProductDetails(
    int id,
  ) async {
    try {
      final response = await remoteDataSource.getProductDetails(id);
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } on FormatException catch (e) {
      return Left(
        Failure(
          errMessage: 'Invalid product details response format: ${e.message}',
        ),
      );
    } on TypeError catch (e) {
      return Left(
        Failure(errMessage: 'Invalid product details data types: $e'),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to fetch product details: $e'));
    }
  }
}
