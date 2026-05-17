import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';

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

    final tokenMap = data['token'] as Map<String, dynamic>;

    final token = _extractTokenString(tokenMap['token'], fieldName: 'token');
    final refreshToken = _extractTokenString(
      tokenMap['refreshToken'],
      fieldName: 'refreshToken',
    );

    return LoginModel(
      token: token,
      refreshToken: refreshToken,
      userId: tokenMap['userId']?.toString() ?? '',
      email: tokenMap['email']?.toString() ?? '',
      fullName: tokenMap['fullName']?.toString() ?? '',
      role: tokenMap['role']?.toString() ?? '',
      expiration: _parseDateTime(tokenMap['expiration']),
    );
  }
  static String _extractTokenString(
    dynamic tokenField, {
    required String fieldName,
  }) {
    if (tokenField is Map) {
      developer.log(
        '⚠️ LoginModel: $fieldName is a Map (nested object)\n'
        'Keys: ${tokenField.keys.toList()}\n'
        'Attempting to extract nested token value',
        name: 'Auth',
      );
    }

    try {
      final token = TokenStorageHelper.normalizeTokenValue(
        tokenField,
        fieldName: fieldName,
      );
      developer.log(
        '✅ LoginModel: Extracted $fieldName\n'
        'Input type: ${tokenField.runtimeType}\n'
        'Output type: ${token.runtimeType}',
        name: 'Auth',
      );
      return token;
    } on FormatException catch (error) {
      developer.log(
        '❌ LoginModel: Failed to extract $fieldName\n'
        'Input type: ${tokenField.runtimeType}\n'
        'Input value: $tokenField\n'
        'Reason: ${error.message}',
        name: 'Auth',
      );
      return '';
    }
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
