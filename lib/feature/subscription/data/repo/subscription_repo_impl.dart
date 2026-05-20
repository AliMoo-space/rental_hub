import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/subscription/data/datasource/subscription_remote_data_source.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';
import 'package:rental_hub/feature/subscription/domain/repo/subscription_repo.dart';

class SubscriptionRepoImpl implements SubscriptionRepo {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SubscriptionResponseEntity>> getSubscriptions() async {
    try {
      final response = await remoteDataSource.getSubscriptions();
      return Right(response);
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
