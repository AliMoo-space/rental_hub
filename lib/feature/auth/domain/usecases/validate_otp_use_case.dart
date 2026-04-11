import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';

class VerifyOtpUseCase {
  final OtpRepository otpRepository;

  VerifyOtpUseCase(this.otpRepository);

  Future<Either<Failure, OtpEntity>> call(OtpParams params) async {
    final email = params.email.trim();
    if (email.isEmpty) {
      return const Left(ValidationFailure(errMessage: 'Enter Your Email'));
    }

    if (!ValidationUtils.isValidEmail(email)) {
      return const Left(
        ValidationFailure(errMessage: 'Please enter a valid email address'),
      );
    }

    final otp = ValidationUtils.normalizeOtp(params.otp);
    if (otp.length != ValidationUtils.otpLength) {
      return const Left(InvalidOtpFailure(errMessage: 'OTP must be 6 digits'));
    }

    if (!ValidationUtils.hasOnlyDigits(otp)) {
      return const Left(
        InvalidOtpFailure(errMessage: 'OTP must contain only digits'),
      );
    }

    return otpRepository.verifyOtp(OtpParams(email: email, otp: otp));
  }
}
