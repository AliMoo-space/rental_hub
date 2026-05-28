import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/datasource/add_listing_remote_data_source.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/domain/repo/add_listing_repo.dart';

class AddListingRepoImpl implements AddListingRepo {
  final AddListingRemoteDataSource remoteDataSource;

  AddListingRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> createProduct(
    CreateProductRequest request,
  ) async {
    try {
      final message = await remoteDataSource.createProduct(request);
      return Right(message);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل إضافة المنتج: ${e.toString()}'));
    }
  }
}
