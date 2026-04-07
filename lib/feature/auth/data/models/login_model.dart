import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.accessToken,
    required super.expiresAtUtc,
    required super.refreshToken,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      accessToken: json['accessToken'] ?? '',
      expiresAtUtc: DateTime.parse(json['expiresAtUtc']),
      refreshToken: json['refreshToken'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'expiresAtUtc': expiresAtUtc.toIso8601String(),
      'refreshToken': refreshToken,
    };
  }
}
