import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';
import 'package:rental_hub/feature/subscription/domain/repo/subscription_repo.dart';

class GetSubscriptionsUseCase {
  final SubscriptionRepo repo;

  GetSubscriptionsUseCase(this.repo);

  Future<Either<Failure, SubscriptionResponseEntity>> call() {
    return repo.getSubscriptions();
  }
}
