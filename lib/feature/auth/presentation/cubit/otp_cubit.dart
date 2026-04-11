import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/auth/domain/entities/validate_otp_params.dart';
import 'package:rental_hub/feature/auth/domain/usecases/resend_otp_use_case.dart';
import 'package:rental_hub/feature/auth/domain/usecases/validate_otp_use_case.dart';

class OtpCubit extends Cubit<OtpState> {
  final String email;
  final VerifyOtpUseCase verifyOtpUseCase;
  final ResendOtpUseCase resendOtpUseCase;
  final int codeLength;
  final int resendSeconds;

  OtpCubit({
    required this.email,
    required this.verifyOtpUseCase,
    required this.resendOtpUseCase,
    this.codeLength = 6,
    this.resendSeconds = 30,
  }) : _digits = List<String>.filled(codeLength, ''),
       _secondsRemaining = resendSeconds,
       super(
         OtpUpdated(
           digits: List<String>.filled(codeLength, ''),
           secondsRemaining: resendSeconds,
           canResend: false,
         ),
       ) {
    _startResendTimer();
  }

  final List<String> _digits;
  Timer? _timer;
  int _secondsRemaining;

  String get otpCode => _digits.join();

  void updateDigit(int index, String value) {
    if (index < 0 || index >= codeLength) {
      return;
    }

    _digits[index] = value;
    _emitUpdated();
  }

  void updateCode(String value) {
    final sanitized = value.replaceAll(RegExp(r'\D'), '');

    for (var i = 0; i < codeLength; i++) {
      _digits[i] = i < sanitized.length ? sanitized[i] : '';
    }

    _emitUpdated();
  }

  Future<void> verifyCode() async {
    if (state is OtpLoading) {
      return;
    }

    emit(
      OtpLoading(
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );

    final result = await verifyOtpUseCase(
      OtpParams(email: email, otp: otpCode),
    );

    result.fold(
      (failure) => _emitFailure(failure),
      (entity) => emit(
        OtpSuccess(
          message: entity.message,
          digits: List<String>.from(_digits),
          secondsRemaining: _secondsRemaining,
          canResend: _secondsRemaining == 0,
        ),
      ),
    );
  }

  Future<void> resendCode() async {
    if (_secondsRemaining > 0 || state is OtpLoading) {
      return;
    }

    final result = await resendOtpUseCase(email);

    result.fold((failure) => _emitFailure(failure), (entity) {
      _resetDigits();
      _startResendTimer();

      emit(
        OtpCodeResent(
          message: entity.message,
          digits: List<String>.from(_digits),
          secondsRemaining: _secondsRemaining,
          canResend: _secondsRemaining == 0,
        ),
      );
    });
  }

  void _resetDigits() {
    for (var i = 0; i < _digits.length; i++) {
      _digits[i] = '';
    }
  }

  void _startResendTimer() {
    _timer?.cancel();
    _secondsRemaining = resendSeconds;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 1) {
        _secondsRemaining = 0;
        timer.cancel();
      } else {
        _secondsRemaining -= 1;
      }
      _emitUpdated();
    });
  }

  void _emitUpdated() {
    emit(
      OtpUpdated(
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );
  }

  void _emitFailure(Failure failure) {
    emit(
      OtpError(
        message: failure.errMessage,
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

abstract class OtpState extends Equatable {
  final List<String> digits;
  final int secondsRemaining;
  final bool canResend;

  const OtpState({
    required this.digits,
    required this.secondsRemaining,
    required this.canResend,
  });

  @override
  List<Object?> get props => [digits, secondsRemaining, canResend];
}

class OtpUpdated extends OtpState {
  const OtpUpdated({
    required super.digits,
    required super.secondsRemaining,
    required super.canResend,
  });
}

class OtpLoading extends OtpState {
  const OtpLoading({
    required super.digits,
    required super.secondsRemaining,
    required super.canResend,
  });
}

class OtpSuccess extends OtpState {
  final String message;

  const OtpSuccess({
    required this.message,
    required super.digits,
    required super.secondsRemaining,
    required super.canResend,
  });

  @override
  List<Object?> get props => [...super.props, message];
}

class OtpCodeResent extends OtpState {
  final String message;

  const OtpCodeResent({
    required this.message,
    required super.digits,
    required super.secondsRemaining,
    required super.canResend,
  });

  @override
  List<Object?> get props => [...super.props, message];
}

class OtpError extends OtpState {
  final String message;

  const OtpError({
    required this.message,
    required super.digits,
    required super.secondsRemaining,
    required super.canResend,
  });

  @override
  List<Object?> get props => [...super.props, message];
}
