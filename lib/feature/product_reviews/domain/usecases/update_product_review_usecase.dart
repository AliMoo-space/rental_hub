import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class UpdateProductReviewUseCase {
  final ProductReviewRepository repository;

  UpdateProductReviewUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int id,
    required int score,
    String? comment,
  }) {
    return repository.updateProductReview(
      id: id,
      score: score,
      comment: comment,
    );
  }
}
