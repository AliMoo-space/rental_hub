import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/profile/domain/repositories/user_profile_repository.dart';

class UploadImageUseCase {
  final UserProfileRepository repository;

  UploadImageUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required Uint8List imageBytes,
    required String fileName,
  }) {
    return repository.uploadProfileImage(
      imageBytes: imageBytes,
      fileName: fileName,
    );
  }
}
