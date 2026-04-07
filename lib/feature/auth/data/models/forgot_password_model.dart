import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';

class ForgotPasswordModel extends ForgotPasswordEntity {
  const ForgotPasswordModel({required super.message});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(message: (json['message'] ?? '').toString());
  }

  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
