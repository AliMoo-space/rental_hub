import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/product_repo.dart';

class GetProducts {
  const GetProducts({required this.productRepo});

  final ProductRepo productRepo;

  Future<Either<Failure, ProductsEntity>> call(int pageNumber) {
    return productRepo.getProducts(pageNumber: pageNumber);
  }
}
