import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  Future<Either<Failure, SignUpEntity>> call(SignUpParams params) {
    return authRepository.signUp(params);
  }
}
