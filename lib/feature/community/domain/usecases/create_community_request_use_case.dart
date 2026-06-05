import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class CreateCommunityRequestUseCase {
  final CommunityRepository repository;

  CreateCommunityRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(CreateCommunityRequestParams params) {
    return repository.createRequest(params);
  }
}
