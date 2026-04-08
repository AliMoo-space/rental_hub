import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:rental_hub/feature/auth/domain/repo/forgot_password_repo.dart';

class ForgotPasswordUseCase {
  final ForgotPasswordRepo forgotPasswordRepo;

  ForgotPasswordUseCase(this.forgotPasswordRepo);

  Future<Either<Failure, ForgotPasswordEntity>> call(String email) {
    return forgotPasswordRepo.forgotPassword(email);
  }
}
