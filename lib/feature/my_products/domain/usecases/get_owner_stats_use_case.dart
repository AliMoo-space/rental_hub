import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/entities/owner_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class GetOwnerStatsUseCase {
  final MyProductsRepo repo;

  GetOwnerStatsUseCase(this.repo);

  Future<Either<Failure, OwnerStatsEntity>> call() {
    return repo.getOwnerStats();
  }
}
