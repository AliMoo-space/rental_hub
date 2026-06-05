import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_requests_query.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class GetMyRequestsUseCase {
  final CommunityRepository repository;

  GetMyRequestsUseCase(this.repository);

  Future<Either<Failure, CommunityRequestsPageEntity>> call(
    MyCommunityRequestsQuery query,
  ) {
    return repository.getMyRequests(query);
  }
}
