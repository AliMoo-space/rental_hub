import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/feature/auth/data/models/login_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';

import 'login_remote_data_source.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer apiConsumer;
  final CacheHelper cacheHelper;

  LoginRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.cacheHelper,
  });

  @override
  Future<LoginEntity> login(LoginParams params) async {
    final response = await apiConsumer.post(
      EndPoints.loginEndpoint,
      data: {'email': params.email, 'password': params.password},
    );

    final loginModel = LoginModel.fromJson(_extractPayload(response.data));

    await cacheHelper.saveSecureData(
      key: 'access_token',
      value: loginModel.accessToken,
    );
    await cacheHelper.saveSecureData(
      key: 'refresh_token',
      value: loginModel.refreshToken,
    );

    return loginModel;
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final nestedData = raw['data'];
      if (nestedData is Map<String, dynamic>) {
        return Map<String, dynamic>.from(nestedData);
      }
      return raw;
    }

    throw ServerException(
      ErrorModel(
        statusCode: 500,
        message: 'Invalid login response format',
        errors: {},
      ),
    );
  }
}
