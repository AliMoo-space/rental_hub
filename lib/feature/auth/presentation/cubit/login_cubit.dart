import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';
import 'package:rental_hub/feature/auth/domain/usecases/login_use_case.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(const LoginInitial());

  Future<void> login(LoginParams params) async {
    if (state is LoginLoading) {
      return;
    }

    emit(const LoginLoading());

    final result = await loginUseCase(params);

    result.fold(
      (failure) => emit(LoginError(failure.errMessage)),
      (entity) => emit(LoginSuccess(entity)),
    );
  }
}
