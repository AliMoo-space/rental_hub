import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String errMessage;
  final int? statusCode;

  const Failure({required this.errMessage, this.statusCode});

  @override
  List<Object?> get props => [errMessage, statusCode, runtimeType];
}

class InvalidOtpFailure extends Failure {
  const InvalidOtpFailure({required super.errMessage});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.errMessage});
}
