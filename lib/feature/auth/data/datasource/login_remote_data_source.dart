import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';

abstract class LoginRemoteDataSource {
  Future<LoginEntity> login(LoginParams params);
}
