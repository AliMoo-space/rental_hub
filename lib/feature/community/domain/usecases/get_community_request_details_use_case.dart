import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class GetCommunityRequestDetailsUseCase {
  final CommunityRepository repository;

  GetCommunityRequestDetailsUseCase(this.repository);

  Future<Either<Failure, CommunityRequestEntity>> call(int id) {
    return repository.getRequestById(id);
  }
}
