import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class GetMyProducts {
  final MyProductsRepo repo;

  GetMyProducts(this.repo);

  Future<Either<Failure, ProductsEntity>> call(int pageNumber) {
    return repo.getMyProducts(pageNumber: pageNumber);
  }
}
