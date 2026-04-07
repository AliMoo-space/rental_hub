import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_params.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordEntity> forgotPassword(ForgotPasswordParams params);
}
