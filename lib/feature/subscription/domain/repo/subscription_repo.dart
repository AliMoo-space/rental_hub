import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';

abstract class SubscriptionRepo {
  Future<Either<Failure, SubscriptionResponseEntity>> getSubscriptions();
}
