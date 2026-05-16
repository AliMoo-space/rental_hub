import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';
import 'package:rental_hub/feature/product_details/domain/repo/product_details_repo.dart';

class ProductDetailsUseCase {
  final ProductDetailsRepo repo;

  ProductDetailsUseCase(this.repo);

  Future<Either<Failure, ProductDetailsEntity>> call(int id) {
    return repo.fetchProductDetails(id);
  }
}
