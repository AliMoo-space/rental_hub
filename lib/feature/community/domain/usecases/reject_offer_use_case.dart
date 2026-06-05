import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class RejectOfferUseCase {
  final CommunityRepository repository;

  RejectOfferUseCase(this.repository);

  Future<Either<Failure, String>> call(int offerId) {
    return repository.rejectOffer(offerId);
  }
}
