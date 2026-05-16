import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, SignUpEntity>> signUp(SignUpParams params) async {
    try {
      final entity = await authRemoteDataSource.signUp(params);
      return Right(entity);
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
