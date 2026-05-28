import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/domain/repositories/user_profile_repository.dart';

class GetProfileUseCase {
  final UserProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, UserProfileEntity>> call() {
    return repository.getProfile();
  }
}
