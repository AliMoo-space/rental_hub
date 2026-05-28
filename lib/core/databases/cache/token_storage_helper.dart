import 'dart:convert';
import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/cache/cache_helper.dart';

class TokenStorageHelper {
  static const String accessTokenKey = 'access_token';
  static const String refreshTokenKey = 'refresh_token';

  final CacheHelper _cacheHelper;

  TokenStorageHelper(this._cacheHelper);

  /// Save access token - MUST be a raw string, not a Map or object
  Future<void> saveAccessToken(String token) async {
    final cleanToken = normalizeTokenValue(token, fieldName: 'accessToken');
    developer.log(
      '💾 TokenStorageHelper: Saving access token\n'
      'Incoming token type: ${token.runtimeType}\n'
      'Stored token type: ${cleanToken.runtimeType}\n'
      'Stored token preview: ${_preview(cleanToken)}',
      name: 'Auth',
    );

    await _cacheHelper.saveSecureData(key: accessTokenKey, value: cleanToken);
  }

  Future<void> saveRefreshToken(String token) async {
    if (token.trim().isEmpty) {
      developer.log(
        'ℹ️ TokenStorageHelper: Skipping empty refresh token',
        name: 'Auth',
      );
      return;
    }

    final cleanToken = normalizeTokenValue(token, fieldName: 'refreshToken');
    developer.log(
      '💾 TokenStorageHelper: Saving refresh token\n'
      'Incoming token type: ${token.runtimeType}\n'
      'Stored token type: ${cleanToken.runtimeType}\n'
      'Stored token preview: ${_preview(cleanToken)}',
      name: 'Auth',
    );

    await _cacheHelper.saveSecureData(key: refreshTokenKey, value: cleanToken);
  }

  /// Get access token - returns raw string only
  Future<String?> getAccessToken() async {
    final storedToken = await _cacheHelper.getSecureData(key: accessTokenKey);
    if (storedToken == null) {
      developer.log(
        '🔑 TokenStorageHelper: No access token stored',
        name: 'Auth',
      );
      return null;
    }

    try {
      final cleanToken = normalizeTokenValue(
        storedToken,
        fieldName: 'storedAccessToken',
      );

      if (cleanToken != storedToken) {
        developer.log(
          '🛠️ TokenStorageHelper: Migrating malformed stored access token\n'
          'Retrieved token type: ${storedToken.runtimeType}\n'
          'Normalized token type: ${cleanToken.runtimeType}\n'
          'Normalized preview: ${_preview(cleanToken)}',
          name: 'Auth',
        );
        await _cacheHelper.saveSecureData(
          key: accessTokenKey,
          value: cleanToken,
        );
      } else {
        developer.log(
          '🔑 TokenStorageHelper: Retrieved access token\n'
          'Retrieved token type: ${storedToken.runtimeType}\n'
          'Returned token type: ${cleanToken.runtimeType}\n'
          'Returned token preview: ${_preview(cleanToken)}',
          name: 'Auth',
        );
      }

      return cleanToken;
    } on FormatException catch (error) {
      developer.log(
        '❌ TokenStorageHelper: Stored access token is invalid\n'
        'Retrieved token type: ${storedToken.runtimeType}\n'
        'Reason: ${error.message}',
        name: 'Auth',
      );
      await _cacheHelper.removeSecureData(key: accessTokenKey);
      return null;
    }
  }

  Future<String?> getRefreshToken() async {
    final storedToken = await _cacheHelper.getSecureData(key: refreshTokenKey);
    if (storedToken == null) return null;

    try {
      final cleanToken = normalizeTokenValue(
        storedToken,
        fieldName: 'storedRefreshToken',
      );
      if (cleanToken != storedToken) {
        await _cacheHelper.saveSecureData(
          key: refreshTokenKey,
          value: cleanToken,
        );
      }
      return cleanToken;
    } on FormatException {
      await _cacheHelper.removeSecureData(key: refreshTokenKey);
      return null;
    }
  }

  Future<void> clearTokens() async {
    developer.log('🗑️ TokenStorageHelper: Clearing all tokens', name: 'Auth');
    await _cacheHelper.removeSecureData(key: accessTokenKey);
    await _cacheHelper.removeSecureData(key: refreshTokenKey);
  }

  Future<String?> getCurrentUserId() async {
    final token = await getAccessToken();
    if (token == null || token.trim().isEmpty) {
      return null;
    }

    return extractUserIdFromJwt(token);
  }

  static String? extractUserIdFromJwt(String token) {
    final parts = token.split('.');
    if (parts.length < 2) {
      return null;
    }

    try {
      final payload = base64Url.normalize(parts[1]);
      final decoded = utf8.decode(base64Url.decode(payload));
      final payloadJson = jsonDecode(decoded);

      if (payloadJson is Map) {
        final map = Map<String, dynamic>.from(payloadJson);
        for (final key in const [
          'userId',
          'sub',
          'nameid',
          'uid',
          'id',
          'user_id',
        ]) {
          final value = map[key];
          if (value != null && value.toString().trim().isNotEmpty) {
            return value.toString();
          }
        }
      }
    } catch (error) {
      developer.log(
        'TokenStorageHelper: failed to decode current user id: $error',
        name: 'Auth',
      );
    }

    return null;
  }

  /// Returns a raw token string from API/storage values.
  ///
  /// Accepts a raw JWT, a JSON object string such as {"token":"..."}, and
  /// Dart's Map.toString() form such as {token: eyJ...}. Rejects anything that
  /// cannot be reduced to a raw token.
  static String normalizeTokenValue(
    dynamic value, {
    String fieldName = 'token',
  }) {
    if (value == null) {
      throw FormatException('$fieldName cannot be null');
    }

    if (value is Map) {
      final nestedValue = _firstTokenCandidate(value);
      if (nestedValue == null) {
        throw FormatException('$fieldName map does not contain a token value');
      }
      return normalizeTokenValue(nestedValue, fieldName: fieldName);
    }

    if (value is! String) {
      throw FormatException(
        '$fieldName must be a String, received ${value.runtimeType}',
      );
    }

    var token = value.trim();
    if (token.isEmpty) {
      throw FormatException('$fieldName cannot be empty');
    }

    if (token.toLowerCase().startsWith('bearer ')) {
      token = token.substring(7).trim();
    }

    final jwtToken = _extractJwtToken(token);
    if (jwtToken != null && jwtToken != token) {
      developer.log(
        '🧹 TokenStorageHelper: Extracted JWT from malformed $fieldName\n'
        'Input type: ${value.runtimeType}\n'
        'Clean token preview: ${_preview(jwtToken)}',
        name: 'Auth',
      );
      return jwtToken;
    }

    if (token.startsWith('{') && token.endsWith('}')) {
      final parsedJsonToken = _extractFromJsonObjectString(token);
      if (parsedJsonToken != null) {
        return normalizeTokenValue(parsedJsonToken, fieldName: fieldName);
      }

      final parsedMapToken = _extractFromDartMapString(token);
      if (parsedMapToken != null) {
        return normalizeTokenValue(parsedMapToken, fieldName: fieldName);
      }

      throw FormatException(
        '$fieldName is an object representation, not a raw token',
      );
    }

    if (_looksMalformed(token)) {
      throw FormatException(
        '$fieldName is malformed: object text was detected',
      );
    }

    return token;
  }

  static dynamic _firstTokenCandidate(Map<dynamic, dynamic> map) {
    for (final key in const [
      'token',
      'accessToken',
      'access_token',
      'refreshToken',
      'refresh_token',
      'value',
      'data',
    ]) {
      final value = map[key];
      if (value is String || value is Map) return value;
    }

    return null;
  }

  static String? _extractFromJsonObjectString(String value) {
    try {
      final decoded = jsonDecode(value);
      if (decoded is Map) {
        final tokenValue = _firstTokenCandidate(decoded);
        return tokenValue?.toString();
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static String? _extractFromDartMapString(String value) {
    final body = value.substring(1, value.length - 1).trim();
    final match = RegExp(
      r'^(token|accessToken|access_token|refreshToken|refresh_token|value|data)\s*:\s*(.+)$',
      caseSensitive: false,
    ).firstMatch(body);

    final token = match?.group(2)?.split(', ').first.trim();
    if (token == null || token.isEmpty) return null;
    return token;
  }

  static String? _extractJwtToken(String value) {
    final match = RegExp(
      r'([A-Za-z0-9_-]+\.[A-Za-z0-9_-]+\.[A-Za-z0-9_-]+)',
    ).firstMatch(value);

    return match?.group(1);
  }

  static bool _looksMalformed(String token) {
    return token.contains('{token:') ||
        token.contains('"token"') ||
        token.contains('accessToken:') ||
        token.contains('"accessToken"') ||
        token.contains('refreshToken:') ||
        token.contains('expiration:') ||
        token.contains('userId:') ||
        token.contains('email:') ||
        token.contains('fullName:') ||
        token.contains('role:') ||
        token.contains(', ');
  }

  static String _preview(String token) {
    if (token.length <= 24) return token;
    return '${token.substring(0, 12)}...${token.substring(token.length - 6)}';
  }
}
