import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_page_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class GetProductReviewsUseCase {
  final ProductReviewRepository repository;

  GetProductReviewsUseCase(this.repository);

  Future<Either<Failure, ProductReviewPageEntity>> call({
    required int productId,
    int pageNumber = 1,
    int pageSize = 10,
  }) {
    return repository.getProductReviews(
      productId: productId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
