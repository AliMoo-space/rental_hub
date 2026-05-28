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
      validateStatus: (status) => status != null && status < 500,
    );

    dio.interceptors.add(authInterceptor.dioInterceptor);

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
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    bool skipAuth = false,
  }) async {
    try {
      final body = _prepareBody(data, isFormData);

      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _throwIfErrorStatus(response);
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
    bool skipAuth = false,
  }) async {
    try {
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _throwIfErrorStatus(response);
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
    bool skipAuth = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _throwIfErrorStatus(response);
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
    bool skipAuth = false,
  }) async {
    try {
      final body = _prepareBody(data, isFormData);

      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _throwIfErrorStatus(response);
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
    bool skipAuth = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _throwIfErrorStatus(response);
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

  void _throwIfErrorStatus(Response<dynamic> response) {
    final statusCode = response.statusCode ?? 0;
    if (statusCode >= 400) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
        type: DioExceptionType.badResponse,
        message: 'Request failed with status code $statusCode',
      );
    }
  }
}
