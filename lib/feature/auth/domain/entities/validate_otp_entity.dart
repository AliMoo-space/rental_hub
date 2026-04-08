import 'package:equatable/equatable.dart';

class ValidateOtpEntity extends Equatable {
  final String message;

  const ValidateOtpEntity({required this.message});

  @override
  List<Object?> get props => [message];
}
