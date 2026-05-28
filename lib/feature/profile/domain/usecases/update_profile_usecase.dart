import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/profile/domain/repositories/user_profile_repository.dart';

class UpdateProfileUseCase {
  final UserProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, bool>> call({
    required String fullName,
    required String phoneNumber,
    required String city,
    required String governorate,
    required String country,
    required String sex,
  }) {
    return repository.updateProfile(
      fullName: fullName,
      phoneNumber: phoneNumber,
      city: city,
      governorate: governorate,
      country: country,
      sex: sex,
    );
  }
}
