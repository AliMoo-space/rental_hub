import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, UserProfileEntity>> getProfile();

  Future<Either<Failure, bool>> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String city,
    required String governorate,
    required String country,
    required String sex,
  });

  Future<Either<Failure, String>> uploadProfileImage({
    required Uint8List imageBytes,
    required String fileName,
  });

  Future<Either<Failure, bool>> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
}
