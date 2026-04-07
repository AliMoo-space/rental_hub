import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordInitial());

  Future<void> resetPassword({
    required String password,
    required String confirmPassword,
  }) async {
    if (state is ResetPasswordLoading) {
      return;
    }

    if (password.isEmpty || confirmPassword.isEmpty) {
      emit(const ResetPasswordError('Please complete all password fields'));
      return;
    }

    if (password.length < 6) {
      emit(const ResetPasswordError('Password must be at least 6 characters'));
      return;
    }

    if (password != confirmPassword) {
      emit(const ResetPasswordError('Passwords do not match'));
      return;
    }

    emit(const ResetPasswordLoading());

    await Future<void>.delayed(const Duration(milliseconds: 900));

    emit(const ResetPasswordSuccess());
  }
}

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPasswordError extends ResetPasswordState {
  final String message;

  const ResetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}
