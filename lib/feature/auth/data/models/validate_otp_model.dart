import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';

class ValidateOtpModel extends ValidateOtpEntity {
  const ValidateOtpModel({required super.message});

  factory ValidateOtpModel.fromJson(Map<String, dynamic> json) {
    return ValidateOtpModel(message: json['message'] as String);
  }
}
