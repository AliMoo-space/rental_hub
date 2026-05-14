import 'package:flutter_test/flutter_test.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/feature/auth/data/models/login_model.dart';

void main() {
  group('token parsing', () {
    test('extracts raw token from Dart Map string', () {
      final token = TokenStorageHelper.normalizeTokenValue(
        '{token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature}',
      );

      expect(token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature');
    });

    test('extracts raw token from JSON object string', () {
      final token = TokenStorageHelper.normalizeTokenValue(
        '{"token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature"}',
      );

      expect(token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature');
    });

    test('login model stores only raw token string', () {
      final loginModel = LoginModel.fromJson({
        'token':
            '{token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature}',
        'refreshToken': {'token': 'refresh-token-value'},
        'userId': '1',
        'email': 'user@example.com',
        'fullName': 'Test User',
        'role': 'User',
        'expiration': '2026-05-14T00:00:00.000Z',
      });

      expect(
        loginModel.token,
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature',
      );
      expect(loginModel.refreshToken, 'refresh-token-value');
    });

    test('extracts jwt when login object fields are appended', () {
      final token = TokenStorageHelper.normalizeTokenValue(
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature, '
        'refreshToken: , expiration: 2026-05-14T21:47:55.142297Z, '
        'userId: 83e358a2-997c-4478-a698-380fb6f02353, '
        'email: user@example.com, fullName: fouad, role: User',
      );

      expect(token, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.signature');
    });

    test('rejects unrecoverable object text', () {
      expect(
        () => TokenStorageHelper.normalizeTokenValue('{unexpected: value}'),
        throwsA(isA<FormatException>()),
      );
    });
  });
}
