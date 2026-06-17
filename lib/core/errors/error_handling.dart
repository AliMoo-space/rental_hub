//!ServerException
import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:rental_hub/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;
  ServerException(this.errorModel);
}

//!CacheException
class CacheException implements Exception {
  final String errorMessage;
  CacheException({required this.errorMessage});
}

class BadCertificateException extends ServerException {
  BadCertificateException(super.errorModel);
}

class ConnectionTimeoutException extends ServerException {
  ConnectionTimeoutException(super.errorModel);
}

class BadResponseException extends ServerException {
  BadResponseException(super.errorModel);
}

class ReceiveTimeoutException extends ServerException {
  ReceiveTimeoutException(super.errorModel);
}

class ConnectionErrorException extends ServerException {
  ConnectionErrorException(super.errorModel);
}

class SendTimeoutException extends ServerException {
  SendTimeoutException(super.errorModel);
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.errorModel);
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.errorModel);
}

class NotFoundException extends ServerException {
  NotFoundException(super.errorModel);
}

class CofficientException extends ServerException {
  CofficientException(super.errorModel);
}

class CancelException extends ServerException {
  CancelException(super.errorModel);
}

class UnknownException extends ServerException {
  UnknownException(super.errorModel);
}

bool isNetworkUnavailableException(Object error) {
  return error is ConnectionErrorException ||
      error is ConnectionTimeoutException ||
      error is ReceiveTimeoutException ||
      error is UnknownException;
}

String friendlyNetworkErrorMessage() {
  return 'الخدمة غير متاحة حالياً. تحقق من اتصال الإنترنت وحاول مرة أخرى.';
}

ErrorModel _buildErrorModel(DioException e) {
  final data = e.response?.data;
  if (data is Map<String, dynamic>) {
    return ErrorModel.fromJson(data);
  }

  return ErrorModel(
    statusCode: e.response?.statusCode ?? 500,
    message: data?.toString() ?? e.message ?? 'Unexpected network error',
    errors: {},
  );
}

void handleDioException(DioException e) {
  final errorModel = _buildErrorModel(e);

  developer.log(
    'DioException handled\n'
    'type=${e.type}\n'
    'status=${e.response?.statusCode}\n'
    'uri=${e.requestOptions.uri}\n'
    'responseBody=${e.response?.data}\n'
    'message=${e.message}\n'
    'parsed=${errorModel.logMessage}',
    name: 'HTTP',
    error: e,
  );

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(errorModel);

    case DioExceptionType.badCertificate:
      throw BadCertificateException(errorModel);

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(errorModel);

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(
        _withFallbackMessage(
          errorModel,
          'انتهت مهلة انتظار الاستجابة من الخادم. حاول مرة أخرى.',
        ),
      );

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(
        _withFallbackMessage(
          errorModel,
          'انتهت مهلة رفع البيانات. حاول تقليل عدد الصور أو حجمها.',
        ),
      );

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw BadResponseException(errorModel);

        case 401: //unauthorized
          throw UnauthorizedException(errorModel);

        case 403: //forbidden
          throw ForbiddenException(errorModel);

        case 404: //not found
          throw NotFoundException(errorModel);

        case 409: //cofficient
          throw CofficientException(errorModel);

        case 504:
          throw BadResponseException(
            ErrorModel(
              statusCode: 504,
              message: errorModel.message,
              errors: {},
            ),
          );

        default:
          throw ServerException(errorModel);
      }

    case DioExceptionType.cancel:
      throw CancelException(errorModel);

    case DioExceptionType.unknown:
      throw UnknownException(errorModel);
  }
}

ErrorModel _withFallbackMessage(ErrorModel model, String fallback) {
  if (model.message.trim().isNotEmpty || model.errors.isNotEmpty) {
    return model;
  }

  return ErrorModel(
    statusCode: model.statusCode,
    message: fallback,
    errors: model.errors,
  );
}
