import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';

class ValidateOtpUseCase {
  final ValidateOtpRepo validateOtpRepo;

  ValidateOtpUseCase(this.validateOtpRepo);

  Future<Either<Failure, ValidateOtpEntity>> call(
    ValidateOtpParams params,
  ) async {
    final otp = params.otp.trim();
    if (otp.length != 6) {
      return Left(Failure(errMessage: "OTP must be 6 digits"));
    }
    if (!RegExp(r'^\d+$').hasMatch(otp)) {
      return Left(Failure(errMessage: "OTP must contain only digits"));
    }

    return await validateOtpRepo.validateOtp(params);
  }
}
