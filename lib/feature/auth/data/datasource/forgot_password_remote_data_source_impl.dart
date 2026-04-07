import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/feature/auth/data/models/forgot_password_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_params.dart';

import 'forgot_password_remote_data_source.dart';

class ForgotPasswordRemoteDataSourceImpl
    implements ForgotPasswordRemoteDataSource {
  final ApiConsumer apiConsumer;

  ForgotPasswordRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ForgotPasswordEntity> forgotPassword(
    ForgotPasswordParams params,
  ) async {
    final response = await apiConsumer.post(
      EndPoints.forgotPasswordEndpoint,
      data: {'email': params.email},
    );

    final payload = _extractPayload(response.data);

    return ForgotPasswordModel.fromJson(payload);
  }

  Map<String, dynamic> _extractPayload(dynamic raw) {
    if (raw is Map<String, dynamic>) {
      final nestedData = raw['data'];

      final dynamic messageCandidate =
          raw['message'] ??
          raw['title'] ??
          raw['detail'] ??
          (nestedData is Map<String, dynamic>
              ? nestedData['message'] ?? nestedData['title']
              : null);

      final message = (messageCandidate ?? '').toString().trim();
      return {
        'message': message.isEmpty
            ? 'Verification code sent successfully'
            : message,
      };
    }

    return const {'message': 'Verification code sent successfully'};
  }
}
