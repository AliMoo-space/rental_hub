import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_entity.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  final SignUpEntity signUpEntity;

  const SignUpSuccess(this.signUpEntity);

  @override
  List<Object?> get props => [signUpEntity];
}

class SignUpError extends SignUpState {
  final String message;

  const SignUpError(this.message);

  @override
  List<Object?> get props => [message];
}
