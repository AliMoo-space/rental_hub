import 'package:dio/dio.dart';

abstract class ApiConsumer {
  Future<Response<dynamic>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  });
}
