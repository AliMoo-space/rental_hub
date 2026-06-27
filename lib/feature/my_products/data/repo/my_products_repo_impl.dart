import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/data/datasource/my_products_remote_data_source.dart';
import 'package:rental_hub/feature/my_products/domain/entities/owner_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_rental_request_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class MyProductsRepoImpl implements MyProductsRepo {
  final MyProductsRemoteDataSource remoteDataSource;

  MyProductsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductsEntity>> getMyProducts({
    required int pageNumber,
  }) async {
    try {
      final result = await remoteDataSource.getMyProducts(
        pageNumber: pageNumber,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> deleteProduct({required int id}) async {
    try {
      final result = await remoteDataSource.deleteProduct(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> suspendProduct({required int id}) async {
    try {
      final result = await remoteDataSource.suspendProduct(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> activateProduct({required int id}) async {
    try {
      final result = await remoteDataSource.activateProduct(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, OwnerStatsEntity>> getOwnerStats() async {
    try {
      final result = await remoteDataSource.getOwnerStats();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductStatsEntity>> getProductStats({
    required int id,
  }) async {
    try {
      final result = await remoteDataSource.getProductStats(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductTransactionEntity>>>
  getProductTransactions({required int id}) async {
    try {
      final result = await remoteDataSource.getProductTransactions(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductRentalRequestEntity>>>
  getProductRentalRequests({required int id}) async {
    try {
      final result = await remoteDataSource.getProductRentalRequests(id: id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
