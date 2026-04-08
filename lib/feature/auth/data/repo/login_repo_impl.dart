import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/data/datasource/login_remote_data_source.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';

class LoginRepoImpl implements LoginRepo {
  final LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl(this.loginRemoteDataSource);

  @override
  Future<Either<Failure, LoginEntity>> login(LoginParams params) async {
    try {
      final loginEntity = await loginRemoteDataSource.login(params);
      return Right(loginEntity);
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
