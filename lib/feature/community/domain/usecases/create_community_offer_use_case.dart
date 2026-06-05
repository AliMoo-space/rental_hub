import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class CreateCommunityOfferUseCase {
  final CommunityRepository repository;

  CreateCommunityOfferUseCase(this.repository);

  Future<Either<Failure, String>> call(CreateCommunityOfferParams params) {
    return repository.createOffer(params);
  }
}
