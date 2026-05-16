import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
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
      validateStatus: (status) => status != null && status < 500,
    );

    dio.interceptors.add(authInterceptor.dioInterceptor);

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          log('🌐 ${options.method} ${options.uri}');
          handler.next(options);
        },
        onResponse: (response, handler) {
          log('✅ ${response.statusCode} ${response.requestOptions.path}');
          handler.next(response);
        },
        onError: (error, handler) {
          log('❌ ${error.response?.statusCode} ${error.message}');
          handler.next(error);
        },
      ),
    );

    if (!kReleaseMode) {
      dio.interceptors.add(
        LogInterceptor(requestBody: true, responseBody: true, error: true),
      );
    }
  }

  @override
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final body = _prepareBody(data, isFormData);

      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);

      return response;
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final body = _prepareBody(data, isFormData);

      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
      );

      return response;
    } on DioException catch (e) {
      handleDioException(e);
      rethrow;
    }
  }

  dynamic _prepareBody(dynamic data, bool isFormData) {
    if (isFormData) {
      if (data is FormData) return data;

      if (data is Map) {
        final safeMap = Map<String, dynamic>.from(data);
        return FormData.fromMap(safeMap);
      }
    }

    return data;
  }
}
