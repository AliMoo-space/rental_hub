//!ServerException
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

  switch (e.type) {
    case DioExceptionType.connectionError:
      throw ConnectionErrorException(errorModel);

    case DioExceptionType.badCertificate:
      throw BadCertificateException(errorModel);

    case DioExceptionType.connectionTimeout:
      throw ConnectionTimeoutException(errorModel);

    case DioExceptionType.receiveTimeout:
      throw ReceiveTimeoutException(errorModel);

    case DioExceptionType.sendTimeout:
      throw SendTimeoutException(errorModel);

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
          throw ServerException(
            ErrorModel(
              statusCode: e.response?.statusCode ?? 500,
              message: 'Unexpected status code: ${e.response?.statusCode}',
              errors: {},
            ),
          );
      }

    case DioExceptionType.cancel:
      throw CancelException(errorModel);

    case DioExceptionType.unknown:
      throw UnknownException(errorModel);
  }
}
