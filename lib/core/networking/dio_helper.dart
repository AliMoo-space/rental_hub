import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rental_hub/core/networking/api_endpoints.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/utils/storage_helper.dart';

class DioHelper {
  Dio? dio;
  DioHelper() {
    dio ??= Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        receiveDataWhenStatusError: true,
      ),
    );

    dio!.interceptors.add(
      PrettyDioLogger(requestBody: true, responseBody: true),
    );

    dio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (!options.path.contains('login')) {
            final token = await getIt<StorageHelper>().getAccessToken();
            if (token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<Response<dynamic>> getRequest({
    required String endPoint,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await dio!.get(endPoint, queryParameters: query);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> postRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio!.post(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> deleteRequest({required String endPoint}) async {
    try {
      final response = await dio!.delete(endPoint);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }

  Future<Response<dynamic>> putRequest({
    required String endPoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio!.put(endPoint, data: data);
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response!;
      }
      rethrow;
    }
  }
}
