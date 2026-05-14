import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';

class AuthInterceptor {
  final TokenStorageHelper _tokenStorageHelper;

  AuthInterceptor(this._tokenStorageHelper);

  Interceptor get dioInterceptor {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final skipAuth = options.extra['skipAuth'] == true;

        developer.log(
          '🔐 AuthInterceptor.onRequest\n'
          'URL: ${options.uri}\n'
          'Method: ${options.method}\n'
          'Skip Auth: $skipAuth',
          name: 'Auth',
        );

        if (!skipAuth) {
          final token = await _tokenStorageHelper.getAccessToken();

          if (token != null && token.isNotEmpty) {
            final authorizationHeader = 'Bearer $token';

            if (!_isValidAuthorizationHeader(authorizationHeader)) {
              developer.log(
                '❌ AuthInterceptor: Refusing malformed Authorization header\n'
                'Retrieved token type: ${token.runtimeType}\n'
                'Authorization header final value: ${_previewHeader(authorizationHeader)}',
                name: 'Auth',
              );
              handler.next(options);
              return;
            }

            options.headers['Authorization'] = authorizationHeader;

            developer.log(
              '✅ AuthInterceptor: Token attached\n'
              'Retrieved token type: ${token.runtimeType}\n'
              'Authorization header final value: ${_previewHeader(authorizationHeader)}\n'
              'Header type: ${options.headers['Authorization'].runtimeType}',
              name: 'Auth',
            );
          } else {
            developer.log(
              '⚠️ AuthInterceptor: No token found for protected request',
              name: 'Auth',
            );
          }
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        // Log 401 errors for debugging
        if (error.response?.statusCode == 401) {
          final currentToken = await _tokenStorageHelper.getAccessToken();
          developer.log(
            '❌ AuthInterceptor: 401 Unauthorized\n'
            'URL: ${error.requestOptions.uri}\n'
            'Token exists: ${currentToken != null}\n'
            'Token is empty: ${currentToken?.isEmpty ?? true}\n'
            'Response: ${error.response?.data}',
            name: 'Auth',
          );
        }
        handler.next(error);
      },
    );
  }
}

bool _isValidAuthorizationHeader(String header) {
  if (!header.startsWith('Bearer ')) return false;

  final token = header.substring(7).trim();
  if (token.isEmpty) return false;
  if (token.startsWith('{') || token.endsWith('}')) return false;
  if (token.contains('{token:') || token.contains('"token"')) return false;
  if (token.contains(',') || token.contains(' ')) return false;
  if (token.contains('refreshToken:') ||
      token.contains('expiration:') ||
      token.contains('userId:') ||
      token.contains('email:') ||
      token.contains('fullName:') ||
      token.contains('role:')) {
    return false;
  }

  return true;
}

String _previewHeader(String header) {
  const prefix = 'Bearer ';
  if (!header.startsWith(prefix)) return header;

  final token = header.substring(prefix.length);
  if (token.length <= 24) return header;
  return '$prefix${token.substring(0, 12)}...${token.substring(token.length - 6)}';
}
