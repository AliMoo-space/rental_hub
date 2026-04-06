import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';

abstract class LoginRepo {
  Future<Either<Failure, LoginEntity>> login(LoginParams params);
}
