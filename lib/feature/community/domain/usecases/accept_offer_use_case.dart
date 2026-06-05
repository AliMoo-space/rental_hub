import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class AcceptOfferUseCase {
  final CommunityRepository repository;

  AcceptOfferUseCase(this.repository);

  Future<Either<Failure, String>> call(int offerId) {
    return repository.acceptOffer(offerId);
  }
}
