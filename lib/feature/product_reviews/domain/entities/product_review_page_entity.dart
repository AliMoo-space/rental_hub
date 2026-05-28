import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';

class ProductReviewPageEntity {
  final List<ProductReviewEntity> items;
  final int totalCount;
  final int pageNumber;
  final int pageSize;

  const ProductReviewPageEntity({
    required this.items,
    required this.totalCount,
    required this.pageNumber,
    required this.pageSize,
  });

  bool get hasMore => items.length < totalCount;
}
