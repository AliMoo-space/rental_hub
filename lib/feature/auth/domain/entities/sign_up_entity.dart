import 'package:equatable/equatable.dart';

class SignUpEntity extends Equatable {
  // Common response fields for sign up.
  final String message;
  final String email;
  final String fullName;
  final String userId;
  final String status;

  // Legacy / client-side fields that other parts of the codebase may expect.
  final String name;
  final String password;
  final String? imagePath;

  const SignUpEntity({
    this.message = '',
    this.email = '',
    this.fullName = '',
    this.userId = '',
    this.status = '',
    this.name = '',
    this.password = '',
    this.imagePath,
  });

  @override
  List<Object?> get props => [
    message,
    userId,
    status,
    email,
    fullName,
    name,
    password,
    imagePath,
  ];
}
