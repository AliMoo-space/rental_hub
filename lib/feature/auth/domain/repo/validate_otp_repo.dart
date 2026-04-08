import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';

abstract class ValidateOtpRepo {
  Future<Either<Failure, ValidateOtpEntity>> validateOtp(
    ValidateOtpParams params,
  );
}
