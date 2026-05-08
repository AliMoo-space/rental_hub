import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/core/utils/response_parser.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.refreshToken,
    required super.token,
    required super.expiration,
    required super.userId,
    required super.email,
    required super.fullName,
    required super.role,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    final data = ResponseParser.extractDataPayload(json);

    return LoginModel(
      token: data['token']?.toString() ?? '',
      refreshToken: data['refreshToken']?.toString() ?? '',
      userId: data['userId']?.toString() ?? '',
      email: data['email']?.toString() ?? '',
      fullName: data['fullName']?.toString() ?? '',
      role: data['role']?.toString() ?? '',
      expiration: _parseDateTime(data['expiration']),
    );
  }
  static DateTime _parseDateTime(dynamic value) {
    if (value == null) {
      return DateTime.now();
    }

    try {
      return DateTime.parse(value.toString());
    } catch (_) {
      return DateTime.now();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'refreshToken': refreshToken,
      'userId': userId,
      'email': email,
      'fullName': fullName,
      'role': role,
      'expiration': expiration.toIso8601String(),
    };
  }
}
