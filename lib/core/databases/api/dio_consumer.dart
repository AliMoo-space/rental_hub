import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rental_hub/core/databases/api/auth_interceptor.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final AuthInterceptor authInterceptor;

  DioConsumer({required this.dio, required this.authInterceptor}) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    dio.interceptors.add(authInterceptor.dioInterceptor);

    // Add logging interceptor
    dio.interceptors.add(_NetworkLoggingInterceptor());

    if (!kReleaseMode) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          compact: true,
          maxWidth: 120,
        ),
      );
    }
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      developer.log(
        '🔹 POST Request: $path\nBaseURL: ${EndPoints.baseUrl}\nData: $data',
      );

      final res = await dio.post(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );

      developer.log('✅ POST Success: $path\nStatus: ${res.statusCode}');
      return res;
    } on DioException catch (e) {
      developer.log(
        '❌ POST Error: $path\nError: ${e.message}\nType: ${e.type}',
      );
      handleDioException(e);
      rethrow;
    } catch (e) {
      developer.log('❌ Unexpected Error: $e');
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      developer.log('🔹 GET Request: $path');

      final res = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      developer.log('✅ GET Success: $path\nStatus: ${res.statusCode}');
      return res;
    } on DioException catch (e) {
      developer.log('❌ GET Error: $path\nError: ${e.message}');
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      developer.log('🔹 DELETE Request: $path');

      final res = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      developer.log('✅ DELETE Success: $path\nStatus: ${res.statusCode}');
      return res;
    } on DioException catch (e) {
      developer.log('❌ DELETE Error: $path\nError: ${e.message}');
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      developer.log('🔹 PATCH Request: $path\nData: $data');

      final res = await dio.patch(
        path,
        data: isFormData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );

      developer.log('✅ PATCH Success: $path\nStatus: ${res.statusCode}');
      return res;
    } on DioException catch (e) {
      developer.log('❌ PATCH Error: $path\nError: ${e.message}');
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      developer.log('🔹 PUT Request: $path\nData: $data');

      final res = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      developer.log('✅ PUT Success: $path\nStatus: ${res.statusCode}');
      return res;
    } on DioException catch (e) {
      developer.log('❌ PUT Error: $path\nError: ${e.message}');
      handleDioException(e);
      rethrow;
    }
  }
}

// Custom logging interceptor
class _NetworkLoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authHeader = options.headers['Authorization'];
    developer.log(
      '🌐 Network Request:\n'
      'URL: ${options.baseUrl}${options.path}\n'
      'Method: ${options.method}\n'
      'Headers (filtered): Content-Type=${options.headers['Content-Type']}, '
      'Authorization=${authHeader != null ? _previewHeader(authHeader.toString()) : 'MISSING'}\n'
      'Data: ${options.data}',
      name: 'Network',
    );

    // CRITICAL: Validate Authorization header format for protected endpoints
    if (!options.extra.containsKey('skipAuth') ||
        options.extra['skipAuth'] != true) {
      if (authHeader != null &&
          !_isValidAuthorizationHeader(authHeader.toString())) {
        developer.log(
          '❌ CRITICAL: Authorization header has INVALID format\n'
          'Value: ${_previewHeader(authHeader.toString())}\n'
          'Should be: Bearer <raw_token>\n'
          'This will cause 401 Unauthorized!',
          name: 'Network',
        );
      }
    }

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final requestHeaders = err.requestOptions.headers;
    final authHeader = requestHeaders['Authorization'];

    developer.log(
      '❌ Network Error:\n'
      'URL: ${err.requestOptions.path}\n'
      'Status Code: ${err.response?.statusCode}\n'
      'Error Type: ${err.type}\n'
      'Message: ${err.message}\n'
      'Authorization Header: ${authHeader != null ? _previewHeader(authHeader.toString()) : "NOT SET"}\n'
      'Response: ${err.response?.data}',
      name: 'Network',
    );
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    developer.log(
      '✅ Network Response:\n'
      'URL: ${response.requestOptions.path}\n'
      'Status: ${response.statusCode}\n'
      'Data: ${response.data}',
      name: 'Network',
    );
    super.onResponse(response, handler);
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
