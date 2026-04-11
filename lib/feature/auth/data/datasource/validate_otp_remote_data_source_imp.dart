import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/models/validate_otp_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';

class OtpRemoteDataSourceImpl implements OtpRemoteDataSource {
  final ApiConsumer apiConsumer;
  OtpRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<OtpEntity> verifyOtp(OtpParams params) async {
    final response = await apiConsumer.post(
      EndPoints.validateOtpEndpoint,
      data: {'email': params.email, 'otp': params.otp},
    );
    final payLoad = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'OTP validated successfully',
    );
    return OtpModel.fromJson(payLoad);
  }

  @override
  Future<OtpEntity> resendOtp(String email) async {
    final response = await apiConsumer.post(
      EndPoints.forgotPasswordEndpoint,
      data: {'email': email},
    );

    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'Verification code sent successfully',
    );

    return OtpModel.fromJson(payload);
  }
}
