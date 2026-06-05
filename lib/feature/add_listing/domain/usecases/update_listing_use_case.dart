import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/add_listing/data/models/update_product_request.dart';
import 'package:rental_hub/feature/add_listing/domain/repo/add_listing_repo.dart';

class UpdateListingUseCase {
  final AddListingRepo repo;

  UpdateListingUseCase(this.repo);

  Future<Either<Failure, String>> call(int id, UpdateProductRequest request) {
    return repo.updateProduct(id, request);
  }
}
