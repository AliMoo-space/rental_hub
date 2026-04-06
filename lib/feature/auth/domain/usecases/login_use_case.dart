import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/login_repo.dart';

class LoginUseCase {
  final LoginRepo loginRepo;

  LoginUseCase(this.loginRepo);

  Future<Either<Failure, LoginEntity>> call(LoginParams params) {
    return loginRepo.login(params);
  }
}
