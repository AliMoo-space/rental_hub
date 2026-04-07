import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/data/datasource/forgot_password_remote_data_source.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/forgot_password_repo.dart';

class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  final ForgotPasswordRemoteDataSource forgotPasswordRemoteDataSource;

  ForgotPasswordRepoImpl(this.forgotPasswordRemoteDataSource);

  @override
  Future<Either<Failure, ForgotPasswordEntity>> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    try {
      final result = await forgotPasswordRemoteDataSource.forgotPassword(
        params,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          errMessage: e.errorModel.firstErrorMessage,
          statusCode: e.errorModel.statusCode,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
