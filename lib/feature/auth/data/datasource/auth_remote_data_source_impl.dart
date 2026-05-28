import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/models/sign_up_model.dart';
import 'package:rental_hub/feature/auth/data/models/sign_up_request.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer apiConsumer;

  AuthRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<SignUpEntity> signUp(SignUpParams params) async {
    developer.log('Starting sign up for ${params.email}', name: 'Auth');

    final request = SignUpRequest(
      fullName: params.fullName,
      email: params.email,
      password: params.password,
      nationalId: params.nationalId,
      idCardImage: params.idCardImage,
    );

    final response = await apiConsumer.post(
      EndPoints.registerEndpoint,
      data: await request.toMap(),
      isFormData: true,
      skipAuth: true,
    );

    if (response.data is! Map<String, dynamic>) {
      return const SignUpEntity(
        message: '',
        email: '',
        fullName: '',
        userId: '',
      );
    }

    final model = SignUpModel.fromJson(response.data as Map<String, dynamic>);
    if (model.userId.trim().isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: response.statusCode ?? 500,
          message: 'Invalid sign up response format',
          errors: {},
        ),
      );
    }

    return model.toEntity();
  }
}
