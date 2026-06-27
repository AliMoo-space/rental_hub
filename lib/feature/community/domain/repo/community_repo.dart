import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_requests_query.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';

abstract class CommunityRepository {
  Future<Either<Failure, CommunityRequestsPageEntity>> getRequests(
    CommunityRequestsQuery query,
  );

  Future<Either<Failure, CommunityRequestEntity>> getRequestById(int id);

  Future<Either<Failure, String>> createRequest(
    CreateCommunityRequestParams params,
  );

  Future<Either<Failure, String>> createOffer(
    CreateCommunityOfferParams params,
  );

  Future<Either<Failure, List<CommunityOfferEntity>>> getMyRequestsOffers();

  Future<Either<Failure, List<CommunityOfferEntity>>> getMyOffers();

  Future<Either<Failure, List<CommunityOfferEntity>>> getRequestOffers(
    int requestId,
  );

  Future<Either<Failure, CommunityRequestsPageEntity>> getMyRequests(
    MyCommunityRequestsQuery query,
  );

  Future<Either<Failure, String>> acceptOffer(int offerId);

  Future<Either<Failure, String>> rejectOffer(int offerId);
}
