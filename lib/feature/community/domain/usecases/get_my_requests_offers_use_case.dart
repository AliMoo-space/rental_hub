import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class GetMyRequestsOffersUseCase {
  final CommunityRepository repository;

  GetMyRequestsOffersUseCase(this.repository);

  Future<Either<Failure, List<CommunityOfferEntity>>> call() {
    return repository.getMyRequestsOffers();
  }
}
