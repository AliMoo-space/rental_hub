import 'package:equatable/equatable.dart';

class OtpParams extends Equatable {
  final String email;
  final String otp;

  const OtpParams({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}
