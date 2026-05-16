import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';

abstract class ProductDetailsRepo {
  Future<Either<Failure, ProductDetailsEntity>> fetchProductDetails(int id);
}
