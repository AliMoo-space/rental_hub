import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/auth/data/models/forgot_password_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';

import 'forgot_password_remote_data_source.dart';

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final ApiConsumer apiConsumer;

  ForgotPasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ForgotPasswordEntity> forgotPassword(String email) async {
    final response = await apiConsumer.post(
      EndPoints.forgotPasswordEndpoint,
      data: {'email': email},
    );

    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'Verification code sent successfully',
    );

    return ForgotPasswordModel.fromJson(payload);
  }
}
