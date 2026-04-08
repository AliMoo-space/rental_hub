import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPasswordEntity> forgotPassword(
    String email,
    // ForgotPasswordParams params
  );
}
