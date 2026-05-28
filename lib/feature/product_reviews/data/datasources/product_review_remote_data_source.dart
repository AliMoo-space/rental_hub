import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/product_reviews/data/models/product_review_model.dart';
import 'package:rental_hub/feature/product_reviews/data/models/rating_summary_model.dart';

abstract class ProductReviewRemoteDataSource {
  Future<ProductReviewPageModel> getProductReviews({
    required int productId,
    int pageNumber = 1,
    int pageSize = 10,
  });

  Future<RatingSummaryModel> getProductRating(int productId);

  Future<int> createProductReview({
    required int productId,
    required int score,
    String? comment,
  });

  Future<void> updateProductReview({
    required int id,
    required int score,
    String? comment,
  });

  Future<void> deleteProductReview(int id);
}

class ProductReviewRemoteDataSourceImpl
    implements ProductReviewRemoteDataSource {
  final ApiConsumer apiConsumer;
  final TokenStorageHelper tokenStorageHelper;

  ProductReviewRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.tokenStorageHelper,
  });

  @override
  Future<ProductReviewPageModel> getProductReviews({
    required int productId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final response = await apiConsumer.get(
      '${EndPoints.productReviewsEndpoint}/product/$productId',
      queryParameters: {'pageNumber': pageNumber, 'pageSize': pageSize},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return ProductReviewPageModel.fromJson(payload);
  }

  @override
  Future<RatingSummaryModel> getProductRating(int productId) async {
    final response = await apiConsumer.get(
      '${EndPoints.productReviewsEndpoint}/rating/$productId',
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return RatingSummaryModel.fromJson(payload);
  }

  @override
  Future<int> createProductReview({
    required int productId,
    required int score,
    String? comment,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.productReviewsEndpoint,
      data: {
        'productId': productId,
        'score': score,
        'comment': comment?.trim().isEmpty == true ? null : comment?.trim(),
      },
      isFormData: false,
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return _parseInt(payload['reviewId'] ?? payload['id']);
  }

  @override
  Future<void> updateProductReview({
    required int id,
    required int score,
    String? comment,
  }) async {
    await apiConsumer.put(
      '${EndPoints.productReviewsEndpoint}/$id',
      data: {
        'score': score,
        'comment': comment?.trim().isEmpty == true ? null : comment?.trim(),
      },
    );
  }

  @override
  Future<void> deleteProductReview(int id) async {
    await apiConsumer.delete('${EndPoints.productReviewsEndpoint}/$id');
  }

  int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }
}
