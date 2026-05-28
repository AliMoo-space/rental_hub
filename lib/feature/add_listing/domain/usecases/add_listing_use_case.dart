import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/domain/repo/add_listing_repo.dart';

class AddListingUseCase {
  final AddListingRepo repo;

  AddListingUseCase(this.repo);

  Future<Either<Failure, String>> call(CreateProductRequest request) {
    return repo.createProduct(request);
  }
}
