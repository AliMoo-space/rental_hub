import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/product_reviews/data/datasources/product_review_remote_data_source.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_page_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/repositories/product_review_repository.dart';

class ProductReviewRepositoryImpl implements ProductReviewRepository {
  final ProductReviewRemoteDataSource remoteDataSource;

  ProductReviewRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, ProductReviewPageEntity>> getProductReviews({
    required int productId,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    try {
      final reviews = await remoteDataSource.getProductReviews(
        productId: productId,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return Right(reviews.toEntity());
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل تحميل التقييمات: $e'));
    }
  }

  @override
  Future<Either<Failure, RatingSummaryEntity>> getProductRating(
    int productId,
  ) async {
    try {
      final rating = await remoteDataSource.getProductRating(productId);
      return Right(rating);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل تحميل ملخص التقييمات: $e'));
    }
  }

  @override
  Future<Either<Failure, int>> createProductReview({
    required int productId,
    required int score,
    String? comment,
  }) async {
    try {
      final reviewId = await remoteDataSource.createProductReview(
        productId: productId,
        score: score,
        comment: comment,
      );
      return Right(reviewId);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل إرسال التقييم: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProductReview({
    required int id,
    required int score,
    String? comment,
  }) async {
    try {
      await remoteDataSource.updateProductReview(
        id: id,
        score: score,
        comment: comment,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل تحديث التقييم: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductReview(int id) async {
    try {
      await remoteDataSource.deleteProductReview(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل حذف التقييم: $e'));
    }
  }
}
