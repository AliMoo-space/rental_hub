import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_rental_request_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class GetProductRentalRequestsUseCase {
  final MyProductsRepo repo;

  GetProductRentalRequestsUseCase(this.repo);

  Future<Either<Failure, List<ProductRentalRequestEntity>>> call({
    required int id,
  }) {
    return repo.getProductRentalRequests(id: id);
  }
}
