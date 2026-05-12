import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options = BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

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
    developer.log(
      '🌐 Network Request:\n'
      'URL: ${options.baseUrl}${options.path}\n'
      'Method: ${options.method}\n'
      'Headers: ${options.headers}\n'
      'Data: ${options.data}',
    );
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    developer.log(
      '❌ Network Error:\n'
      'URL: ${err.requestOptions.path}\n'
      'Status Code: ${err.response?.statusCode}\n'
      'Error Type: ${err.type}\n'
      'Message: ${err.message}\n'
      'Response: ${err.response?.data}',
      name: 'DioError',
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
    );
    super.onResponse(response, handler);
  }
}
