import 'dart:io';

import 'package:dio/dio.dart';

class SignUpRequest {
  final String fullName;
  final String email;
  final String password;
  final String nationalId;
  final File idCardImage;

  const SignUpRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.idCardImage,
  });

  Future<Map<String, dynamic>> toMap() async {
    return {
      'FullName': fullName.trim(),
      'Email': email.trim(),
      'Password': password,
      'NationalId': nationalId.trim(),
      'IdCardImage': await MultipartFile.fromFile(
        idCardImage.path,
        filename: idCardImage.path.split(Platform.pathSeparator).last,
      ),
    };
  }

  Future<FormData> toFormData() async {
    return FormData.fromMap(await toMap());
  }
}
