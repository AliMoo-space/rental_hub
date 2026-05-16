import 'dart:io';

import 'package:equatable/equatable.dart';

class SignUpParams extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String nationalId;
  final File idCardImage;

  const SignUpParams({
    required this.fullName,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.idCardImage,
  });

  @override
  List<Object?> get props => [
    fullName,
    email,
    password,
    nationalId,
    idCardImage.path,
  ];
}
