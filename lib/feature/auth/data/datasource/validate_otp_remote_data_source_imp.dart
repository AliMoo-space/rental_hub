import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/auth/data/datasource/validate_otp_remote_data_source.dart';
import 'package:rental_hub/feature/auth/data/models/validate_otp_model.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';

class ValidateOtpRemoteDataSourceImp implements ValidateOtpRemoteDataSource {
  final ApiConsumer apiConsumer;
  ValidateOtpRemoteDataSourceImp({required this.apiConsumer});

  @override
  Future<ValidateOtpEntity> validateOtp(ValidateOtpParams params) async {
    final response = await apiConsumer.post(
      EndPoints.validateOtpEndpoint,
      data: {'email': params.email, 'otp': params.otp},
    );
    final payLoad = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'OTP validated successfully',
    );
    return ValidateOtpModel.fromJson(payLoad);
  }
}
