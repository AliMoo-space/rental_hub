import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class DeleteProductReviewUseCase {
  final ProductReviewRepository repository;

  DeleteProductReviewUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) {
    return repository.deleteProductReview(id);
  }
}
