import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_entity.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginEntity loginEntity;

  const LoginSuccess(this.loginEntity);

  @override
  List<Object?> get props => [
    loginEntity.accessToken,
    loginEntity.expiresAtUtc,
    loginEntity.refreshToken,
  ];
}

class LoginError extends LoginState {
  final String message;

  const LoginError(this.message);

  @override
  List<Object?> get props => [message];
}
