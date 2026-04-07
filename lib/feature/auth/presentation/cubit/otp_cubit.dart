import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpCubit extends Cubit<OtpState> {
  final int codeLength;
  final int resendSeconds;

  OtpCubit({this.codeLength = 6, this.resendSeconds = 30})
    : _digits = List<String>.filled(codeLength, ''),
      super(
        OtpInitial(
          digits: List<String>.filled(codeLength, ''),
          secondsRemaining: resendSeconds,
          canResend: false,
        ),
      ) {
    _startResendTimer();
  }

  final List<String> _digits;
  Timer? _timer;
  int _secondsRemaining = 0;

  String get otpCode => _digits.join();

  void updateDigit(int index, String value) {
    if (index < 0 || index >= codeLength) {
      return;
    }

    _digits[index] = value;
    _emitInitial();
  }

  Future<void> verifyCode() async {
    if (state is OtpLoading) {
      return;
    }

    if (_digits.any((digit) => digit.isEmpty)) {
      emit(
        OtpError(
          message: 'Please enter the complete code',
          digits: List<String>.from(_digits),
          secondsRemaining: _secondsRemaining,
          canResend: _secondsRemaining == 0,
        ),
      );
      return;
    }

    emit(
      OtpLoading(
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );

    await Future<void>.delayed(const Duration(milliseconds: 900));

    emit(
      OtpSuccess(
        message: 'Code verified successfully',
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );
  }

  Future<void> resendCode() async {
    if (_secondsRemaining > 0 || state is OtpLoading) {
      return;
    }

    for (var i = 0; i < _digits.length; i++) {
      _digits[i] = '';
    }

    _startResendTimer();

    emit(
      OtpSuccess(
        message: 'A new verification code has been sent',
        digits: List<String>.from(_digits),
        secondsRemaining: _secondsRemaining,
        canResend: _secondsRemaining == 0,
      ),
    );
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
      _emitInitial();
    });
  }

  void _emitInitial() {
    emit(
      OtpInitial(
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

class OtpInitial extends OtpState {
  const OtpInitial({
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
