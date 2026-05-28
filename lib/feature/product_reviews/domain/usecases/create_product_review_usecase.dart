import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class CreateProductReviewUseCase {
  final ProductReviewRepository repository;

  CreateProductReviewUseCase(this.repository);

  Future<Either<Failure, int>> call({
    required int productId,
    required int score,
    String? comment,
  }) {
    return repository.createProductReview(
      productId: productId,
      score: score,
      comment: comment,
    );
  }
}
