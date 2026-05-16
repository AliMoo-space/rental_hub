import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';

abstract class AuthRemoteDataSource {
  Future<SignUpEntity> signUp(SignUpParams params);
}
