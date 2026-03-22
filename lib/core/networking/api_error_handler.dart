import 'package:dio/dio.dart';

class ApiErrorHandler {
  static String handle(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
          return "Connection timeout";

        case DioExceptionType.receiveTimeout:
          return "Receive timeout";

        case DioExceptionType.connectionError:
          return "No internet connection";

        case DioExceptionType.badResponse:
          return _handleStatusCode(error.response?.statusCode);

        default:
          return "Unexpected error occurred";
      }
    }
    return "Something went wrong";
  }

  static String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return "Bad request";

      case 401:
        return "Unauthorized";

      case 404:
        return "Not found";

      case 500:
        return "Server error";

      default:
        return "Server error";
    }
  }
}
