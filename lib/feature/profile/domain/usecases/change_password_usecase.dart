import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/profile/domain/repositories/user_profile_repository.dart';

class ChangePasswordUseCase {
  final UserProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) {
    return repository.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );
  }
}
