import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

abstract class ProductRepo {
  Future<Either<Failure, ProductsEntity>> getProducts({
    required int pageNumber,
  });
}
