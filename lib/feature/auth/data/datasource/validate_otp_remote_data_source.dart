import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';

abstract class OtpRemoteDataSource {
  Future<OtpEntity> verifyOtp(OtpParams params);

  Future<OtpEntity> resendOtp(String email);
}
