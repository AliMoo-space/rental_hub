import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';

abstract class ForgotPasswordRepo {
  Future<Either<Failure, ForgotPasswordEntity>> forgotPassword(String email);
}
