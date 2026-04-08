import 'package:equatable/equatable.dart';

class ValidateOtpParams extends Equatable {
  final String email;
  final String otp;

  const ValidateOtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
