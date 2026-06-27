import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/data/models/update_product_request.dart';

abstract class AddListingRepo {
  Future<Either<Failure, String>> createProduct(CreateProductRequest request);
  Future<Either<Failure, String>> updateProduct(
    int id,
    UpdateProductRequest request,
  );
}
