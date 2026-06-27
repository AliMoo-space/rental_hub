import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/community/data/datasource/community_remote_data_source.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_requests_query.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';
import 'package:rental_hub/feature/community/domain/repo/community_repo.dart';

class CommunityRepositoryImpl implements CommunityRepository {
  final CommunityRemoteDataSource remoteDataSource;

  CommunityRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, CommunityRequestsPageEntity>> getRequests(
    CommunityRequestsQuery query,
  ) {
    return _run(() => remoteDataSource.getRequests(query));
  }

  @override
  Future<Either<Failure, CommunityRequestEntity>> getRequestById(int id) {
    return _run(() => remoteDataSource.getRequestById(id));
  }

  @override
  Future<Either<Failure, String>> createRequest(
    CreateCommunityRequestParams params,
  ) {
    return _run(() => remoteDataSource.createRequest(params));
  }

  @override
  Future<Either<Failure, String>> createOffer(
    CreateCommunityOfferParams params,
  ) {
    return _run(() => remoteDataSource.createOffer(params));
  }

  @override
  Future<Either<Failure, List<CommunityOfferEntity>>> getMyRequestsOffers() {
    return _run(() => remoteDataSource.getMyRequestsOffers());
  }

  @override
  Future<Either<Failure, List<CommunityOfferEntity>>> getMyOffers() {
    return _run(() => remoteDataSource.getMyOffers());
  }

  @override
  Future<Either<Failure, CommunityRequestsPageEntity>> getMyRequests(
    MyCommunityRequestsQuery query,
  ) {
    return _run(() => remoteDataSource.getMyRequests(query));
  }

  @override
  Future<Either<Failure, List<CommunityOfferEntity>>> getRequestOffers(
    int requestId,
  ) {
    return _run(() => remoteDataSource.getRequestOffers(requestId));
  }

  @override
  Future<Either<Failure, String>> acceptOffer(int offerId) {
    return _run(() => remoteDataSource.acceptOffer(offerId));
  }

  @override
  Future<Either<Failure, String>> rejectOffer(int offerId) {
    return _run(() => remoteDataSource.rejectOffer(offerId));
  }

  Future<Either<Failure, T>> _run<T>(Future<T> Function() action) async {
    try {
      final result = await action();
      return Right(result);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
