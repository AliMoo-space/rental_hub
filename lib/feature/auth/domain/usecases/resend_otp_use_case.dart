import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/repo/validate_otp_repo.dart';

class ResendOtpUseCase {
  final OtpRepository otpRepository;

  ResendOtpUseCase(this.otpRepository);

  Future<Either<Failure, OtpEntity>> call(String email) async {
    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      return const Left(ValidationFailure(errMessage: 'Enter Your Email'));
    }

    if (!ValidationUtils.isValidEmail(trimmedEmail)) {
      return const Left(
        ValidationFailure(errMessage: 'Please enter a valid email address'),
      );
    }

    return otpRepository.resendOtp(trimmedEmail);
  }
}
