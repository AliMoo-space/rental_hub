import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class GetProductRatingUseCase {
  final ProductReviewRepository repository;

  GetProductRatingUseCase(this.repository);

  Future<Either<Failure, RatingSummaryEntity>> call(int productId) {
    return repository.getProductRating(productId);
  }
}
