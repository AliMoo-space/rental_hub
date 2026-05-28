import 'dart:developer' as developer;
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/auth/data/models/login_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';

import 'login_remote_data_source.dart';

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final ApiConsumer apiConsumer;
  final TokenStorageHelper tokenStorageHelper;

  LoginRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.tokenStorageHelper,
  });

  @override
  Future<LoginEntity> login(LoginParams params) async {
    developer.log(
      '🔐 LoginRemoteDataSourceImpl: Starting login\n'
      'Email: ${params.email}',
      name: 'Auth',
    );

    final response = await apiConsumer.post(
      EndPoints.loginEndpoint,
      data: {'email': params.email, 'password': params.password},
      isFormData: false,
      skipAuth: true,
    );

    final redirectedResponse = await _retryRedirectIfNeeded(response, params);
    if (redirectedResponse != null) {
      return redirectedResponse;
    }

    developer.log(
      '✅ LoginRemoteDataSourceImpl: Received login response\n'
      'Status: ${response.statusCode}\n'
      'Response type: ${response.data.runtimeType}',
      name: 'Auth',
    );

    final loginModel = LoginModel.fromJson(_extractPayload(response.data));

    // CRITICAL: Validate token is a raw string BEFORE saving
    if (loginModel.token.isEmpty) {
      developer.log(
        '❌ LoginRemoteDataSourceImpl: CRITICAL - Token is empty after parsing!',
        name: 'Auth',
      );
      throw ServerException(
        ErrorModel(
          statusCode: 500,
          message: 'Login token is empty',
          errors: {},
        ),
      );
    }

    if (loginModel.token.startsWith('{') && loginModel.token.endsWith('}')) {
      developer.log(
        '❌ LoginRemoteDataSourceImpl: CRITICAL - Token is object.toString() representation\n'
        'Token: ${loginModel.token}\n'
        'LoginModel.fromJson must extract token as raw string!',
        name: 'Auth',
      );
      throw ServerException(
        ErrorModel(
          statusCode: 500,
          message: 'Token format is invalid',
          errors: {},
        ),
      );
    }

    // Save tokens
    developer.log('💾 LoginRemoteDataSourceImpl: Saving tokens', name: 'Auth');
    await tokenStorageHelper.saveAccessToken(loginModel.token);
    if (loginModel.refreshToken.trim().isNotEmpty) {
      await tokenStorageHelper.saveRefreshToken(loginModel.refreshToken);
    }

    // Verify tokens were saved correctly
    final savedToken = await tokenStorageHelper.getAccessToken();
    if (savedToken != loginModel.token) {
      developer.log(
        '❌ LoginRemoteDataSourceImpl: CRITICAL - Token changed after save!\n'
        'Original: ${loginModel.token}\n'
        'Retrieved: $savedToken',
        name: 'Auth',
      );
    } else {
      developer.log(
        '✅ LoginRemoteDataSourceImpl: Token saved and verified correctly',
        name: 'Auth',
      );
    }

    return loginModel;
  }

  Future<LoginEntity?> _retryRedirectIfNeeded(
    dynamic response,
    LoginParams params,
  ) async {
    final statusCode = response.statusCode ?? 0;
    if (statusCode != 307 && statusCode != 308) {
      return null;
    }

    final location = response.headers.value('location')?.trim();
    if (location == null || location.isEmpty) {
      developer.log(
        'LoginRemoteDataSourceImpl: Redirect response received without a Location header',
        name: 'Auth',
      );
      return null;
    }

    developer.log(
      ' LoginRemoteDataSourceImpl: Following redirect to $location',
      name: 'Auth',
    );

    final redirectedResponse = await apiConsumer.post(
      location,
      data: {'email': params.email, 'password': params.password},
      isFormData: false,
      skipAuth: true,
    );

    developer.log(
      '✅ LoginRemoteDataSourceImpl: Received redirected login response\n'
      'Status: ${redirectedResponse.statusCode}\n'
      'Response type: ${redirectedResponse.data.runtimeType}',
      name: 'Auth',
    );

    final loginModel = LoginModel.fromJson(
      _extractPayload(redirectedResponse.data),
    );

    if (loginModel.token.isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: 500,
          message: 'Login token is empty',
          errors: {},
        ),
      );
    }

    await tokenStorageHelper.saveAccessToken(loginModel.token);
    if (loginModel.refreshToken.trim().isNotEmpty) {
      await tokenStorageHelper.saveRefreshToken(loginModel.refreshToken);
    }

    return loginModel;
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    final payload = ResponseParser.extractDataPayload(raw);
    if (payload.isNotEmpty) {
      return payload;
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
