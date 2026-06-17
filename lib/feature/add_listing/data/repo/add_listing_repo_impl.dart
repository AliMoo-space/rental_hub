import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/datasource/add_listing_remote_data_source.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/data/models/update_product_request.dart';
import 'package:rental_hub/feature/add_listing/domain/repo/add_listing_repo.dart';

class AddListingRepoImpl implements AddListingRepo {
  static const _logName = 'AddListing';

  final AddListingRemoteDataSource remoteDataSource;

  AddListingRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, String>> createProduct(
    CreateProductRequest request,
  ) async {
    try {
      final message = await remoteDataSource.createProduct(request);
      developer.log('createProduct succeeded: $message', name: _logName);
      return Right(message);
    } on ServerException catch (e, stackTrace) {
      _logServerException('createProduct', e, stackTrace);
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e, stackTrace) {
      developer.log(
        'createProduct unexpected error: $e',
        name: _logName,
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        Failure(
          errMessage: e.toString().trim().isEmpty
              ? 'فشل إضافة المنتج. حاول مرة أخرى.'
              : 'فشل إضافة المنتج: $e',
        ),
      );
    }
  }

  @override
  Future<Either<Failure, String>> updateProduct(
    int id,
    UpdateProductRequest request,
  ) async {
    try {
      final message = await remoteDataSource.updateProduct(id, request);
      developer.log('updateProduct succeeded: $message', name: _logName);
      return Right(message);
    } on ServerException catch (e, stackTrace) {
      _logServerException('updateProduct', e, stackTrace);
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e, stackTrace) {
      developer.log(
        'updateProduct unexpected error: $e',
        name: _logName,
        error: e,
        stackTrace: stackTrace,
      );
      return Left(
        Failure(
          errMessage: e.toString().trim().isEmpty
              ? 'فشل تعديل المنتج. حاول مرة أخرى.'
              : 'فشل تعديل المنتج: $e',
        ),
      );
    }
  }

  void _logServerException(
    String action,
    ServerException exception,
    StackTrace stackTrace,
  ) {
    developer.log(
      '$action failed\n'
      'exception=${exception.runtimeType}\n'
      '${exception.errorModel.logMessage}\n'
      'userMessage=${exception.errorModel.firstErrorMessage}',
      name: _logName,
      error: exception,
      stackTrace: stackTrace,
    );
  }
}
