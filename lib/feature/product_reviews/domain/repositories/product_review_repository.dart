import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_page_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';

abstract class ProductReviewRepository {
  Future<Either<Failure, ProductReviewPageEntity>> getProductReviews({
    required int productId,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<Either<Failure, RatingSummaryEntity>> getProductRating(int productId);

  Future<Either<Failure, int>> createProductReview({
    required int productId,
    required int score,
    String? comment,
  });

  Future<Either<Failure, void>> updateProductReview({
    required int id,
    required int score,
    String? comment,
  });

  Future<Either<Failure, void>> deleteProductReview(int id);
}
