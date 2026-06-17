import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as developer;
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rental_hub/core/databases/api/auth_interceptor.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/utils/image_upload_utils.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;
  final AuthInterceptor authInterceptor;

  DioConsumer({
    required this.dio,
    required this.authInterceptor,
    String? baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(minutes: 5),
  }) {
    final resolvedBaseUrl = baseUrl ?? dio.options.baseUrl;
    dio.options = BaseOptions(
      baseUrl: resolvedBaseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
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
      final options = _buildRequestOptions(
        body: body,
        isFormData: isFormData,
        skipAuth: skipAuth,
      );
      _logRequest(
        method: 'POST',
        path: path,
        queryParameters: queryParameters,
        body: body,
        skipAuth: skipAuth,
      );

      final response = await dio.post(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      _logResponse(method: 'POST', path: path, response: response);
      _throwIfErrorStatus(response);
      return response;
    } on DioException catch (e) {
      _logDioException(method: 'POST', path: path, error: e);
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
      _logRequest(
        method: 'GET',
        path: path,
        queryParameters: queryParameters,
        skipAuth: skipAuth,
      );
      final response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _logResponse(method: 'GET', path: path, response: response);
      _throwIfErrorStatus(response);
      return response;
    } on DioException catch (e) {
      _logDioException(method: 'GET', path: path, error: e);
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
      _logRequest(
        method: 'DELETE',
        path: path,
        data: data,
        queryParameters: queryParameters,
        skipAuth: skipAuth,
      );
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(extra: {'skipAuth': skipAuth}),
      );

      _logResponse(method: 'DELETE', path: path, response: response);
      _throwIfErrorStatus(response);
      return response;
    } on DioException catch (e) {
      _logDioException(method: 'DELETE', path: path, error: e);
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
      final options = _buildRequestOptions(
        body: body,
        isFormData: isFormData,
        skipAuth: skipAuth,
      );
      _logRequest(
        method: 'PATCH',
        path: path,
        queryParameters: queryParameters,
        body: body,
        skipAuth: skipAuth,
      );

      final response = await dio.patch(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      _logResponse(method: 'PATCH', path: path, response: response);
      _throwIfErrorStatus(response);
      return response;
    } on DioException catch (e) {
      _logDioException(method: 'PATCH', path: path, error: e);
      handleDioException(e);
      rethrow;
    }
  }

  @override
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    bool skipAuth = false,
  }) async {
    try {
      final body = _prepareBody(data, isFormData);
      final options = _buildRequestOptions(
        body: body,
        isFormData: isFormData,
        skipAuth: skipAuth,
      );
      _logRequest(
        method: 'PUT',
        path: path,
        queryParameters: queryParameters,
        body: body,
        skipAuth: skipAuth,
      );
      final response = await dio.put(
        path,
        data: body,
        queryParameters: queryParameters,
        options: options,
      );

      _logResponse(method: 'PUT', path: path, response: response);
      _throwIfErrorStatus(response);
      return response;
    } on DioException catch (e) {
      _logDioException(method: 'PUT', path: path, error: e);
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

  bool _isMultipartBody(dynamic body, bool isFormData) {
    return isFormData || body is FormData;
  }

  Options _buildRequestOptions({
    required dynamic body,
    required bool isFormData,
    required bool skipAuth,
  }) {
    if (!_isMultipartBody(body, isFormData)) {
      return Options(extra: {'skipAuth': skipAuth});
    }

    return ImageUploadUtils.dioMultipartOptions(skipAuth: skipAuth);
  }

  String _describeRequestBody(Object? body) {
    if (body is FormData) {
      return 'FormData(fields=${body.fields.length}, files=${body.files.length})';
    }
    return body?.toString() ?? '<none>';
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

  void _logRequest({
    required String method,
    required String path,
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
    Object? body,
  }) {
    developer.log(
      'HTTP $method $path\n'
      'skipAuth=$skipAuth\n'
      'queryParameters=${queryParameters ?? const {}}\n'
      'data=${_describeRequestBody(body ?? data)}',
      name: 'HTTP',
    );

    if (body is FormData || data is FormData) {
      final formData = (body ?? data) as FormData;
      developer.log(
        'HTTP $method $path multipart upload: '
        'contentType=${Headers.multipartFormDataContentType}, '
        'sendTimeout=${ImageUploadUtils.uploadSendTimeout.inSeconds}s, '
        'fileCount=${formData.files.length}',
        name: 'HTTP',
      );
    }
  }

  void _logResponse({
    required String method,
    required String path,
    required Response<dynamic> response,
  }) {
    developer.log(
      'HTTP $method $path -> ${response.statusCode}\n'
      'responseType=${response.data.runtimeType}\n'
      'responseBody=${response.data}',
      name: 'HTTP',
    );
  }

  void _logDioException({
    required String method,
    required String path,
    required DioException error,
  }) {
    developer.log(
      'HTTP $method $path failed\n'
      'type=${error.type}\n'
      'status=${error.response?.statusCode}\n'
      'responseBody=${error.response?.data}\n'
      'message=${error.message}\n'
      'error=${error.error}',
      name: 'HTTP',
    );
  }
}
