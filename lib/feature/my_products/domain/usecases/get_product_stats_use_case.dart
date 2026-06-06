import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class GetProductStatsUseCase {
  final MyProductsRepo repo;

  GetProductStatsUseCase(this.repo);

  Future<Either<Failure, ProductStatsEntity>> call({required int id}) {
    return repo.getProductStats(id: id);
  }
}
