import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_entity.dart';
import 'package:rental_hub/feature/auth/domain/entities/forgot_password_params.dart';
import 'package:rental_hub/feature/auth/domain/usecases/forgot_password_use_case.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotPasswordCubit(this.forgotPasswordUseCase)
    : super(const ForgotPasswordInitial());

  Future<void> sendResetRequest(String email) async {
    if (state is ForgotPasswordLoading) {
      return;
    }

    final trimmedEmail = email.trim();

    if (trimmedEmail.isEmpty) {
      emit(const ForgotPasswordError('Enter Your Email'));
      return;
    }

    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(trimmedEmail)) {
      emit(const ForgotPasswordError('Please enter a valid email address'));
      return;
    }

    emit(const ForgotPasswordLoading());

    final result = await forgotPasswordUseCase(
      ForgotPasswordParams(email: trimmedEmail),
    );

    result.fold(
      (failure) => emit(ForgotPasswordError(failure.errMessage)),
      (entity) =>
          emit(ForgotPasswordSuccess(email: trimmedEmail, entity: entity)),
    );
  }
}

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
}

class ForgotPasswordLoading extends ForgotPasswordState {
  const ForgotPasswordLoading();
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  final ForgotPasswordEntity entity;

  const ForgotPasswordSuccess({required this.email, required this.entity});

  @override
  List<Object?> get props => [email, entity];
}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;

  const ForgotPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
