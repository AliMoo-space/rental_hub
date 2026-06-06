import 'package:dio/dio.dart';
import 'dart:developer' as developer;
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';

class AuthInterceptor {
  final TokenStorageHelper _tokenStorageHelper;

  AuthInterceptor(this._tokenStorageHelper);

  Interceptor get dioInterceptor {
    return QueuedInterceptorsWrapper(
      onRequest: (options, handler) async {
        final skipAuth = options.extra['skipAuth'] == true;
        developer.log(
          'AuthInterceptor.onRequest: ${options.method} ${options.uri}\n'
          'skipAuth=$skipAuth',
          name: 'Auth',
        );

        if (!skipAuth) {
          final token = await _tokenStorageHelper.getAccessToken();

          if (token != null && token.isNotEmpty) {
            final authorizationHeader = 'Bearer $token';

            if (!_isValidAuthorizationHeader(authorizationHeader)) {
              handler.reject(
                DioException(
                  requestOptions: options,
                  error: 'Invalid auth token',
                  type: DioExceptionType.cancel,
                ),
              );
              return;
            }

            options.headers['Authorization'] = authorizationHeader;
            developer.log(
              'AuthInterceptor.onRequest: attached Authorization header\n'
              'Token preview: ${_previewToken(token)}',
              name: 'Auth',
            );
          } else {
            developer.log(
              'AuthInterceptor.onRequest: no access token available',
              name: 'Auth',
            );
          }
        }

        handler.next(options);
      },
      onError: (error, handler) async {
        handler.next(error);
      },
    );
  }
}

String _previewToken(String token) {
  if (token.length <= 16) return token;
  return '${token.substring(0, 8)}...${token.substring(token.length - 8)}';
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
