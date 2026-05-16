import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, SignUpEntity>> signUp(SignUpParams params);
}
