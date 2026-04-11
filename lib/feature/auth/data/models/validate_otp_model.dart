import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';

class OtpModel extends OtpEntity {
  const OtpModel({required super.message});

  factory OtpModel.fromJson(Map<String, dynamic> json) {
    return OtpModel(message: json['message'] as String);
  }
}
