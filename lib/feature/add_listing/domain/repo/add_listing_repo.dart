import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';

abstract class AddListingRepo {
  Future<Either<Failure, String>> createProduct(CreateProductRequest request);
}
