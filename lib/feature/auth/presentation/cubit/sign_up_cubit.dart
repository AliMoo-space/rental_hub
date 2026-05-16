import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/feature/auth/domain/entities/sign_up_params.dart';
import 'package:rental_hub/feature/auth/domain/usecases/sign_up_use_case.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;

  SignUpCubit(this.signUpUseCase) : super(const SignUpInitial());

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required String nationalId,
    required File? idCardImage,
  }) async {
    if (state is SignUpLoading) {
      return;
    }

    final validationError = validateInputs(
      fullName: fullName,
      email: email,
      password: password,
      nationalId: nationalId,
      idCardImage: idCardImage,
    );

    if (validationError != null) {
      emit(SignUpError(validationError));
      return;
    }

    emit(const SignUpLoading());

    final result = await signUpUseCase(
      SignUpParams(
        fullName: fullName.trim(),
        email: email.trim(),
        password: password,
        nationalId: nationalId.trim(),
        idCardImage: idCardImage!,
      ),
    );

    result.fold(
      (failure) => emit(SignUpError(failure.errMessage)),
      (entity) => emit(SignUpSuccess(entity)),
    );
  }

  String? validateInputs({
    required String fullName,
    required String email,
    required String password,
    required String nationalId,
    required File? idCardImage,
  }) {
    if (fullName.trim().isEmpty) {
      return 'Full name is required';
    }
    if (email.trim().isEmpty) {
      return 'Email is required';
    }
    if (!ValidationUtils.isValidEmail(email)) {
      return 'Enter a valid email address';
    }
    if (password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (nationalId.trim().isEmpty) {
      return 'National ID is required';
    }
    if (idCardImage == null) {
      return 'ID card image is required';
    }

    return null;
  }
}
