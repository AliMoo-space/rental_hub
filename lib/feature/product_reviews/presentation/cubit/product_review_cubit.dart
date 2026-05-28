import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_page_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/create_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/delete_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/get_product_rating_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/get_product_reviews_usecase.dart';
import 'package:rental_hub/feature/product_reviews/domain/usecases/update_product_review_usecase.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_state.dart';

class ProductReviewCubit extends Cubit<ProductReviewState> {
  static const int _pageSize = 10;

  final GetProductReviewsUseCase getProductReviewsUseCase;
  final GetProductRatingUseCase getProductRatingUseCase;
  final CreateProductReviewUseCase createProductReviewUseCase;
  final UpdateProductReviewUseCase updateProductReviewUseCase;
  final DeleteProductReviewUseCase deleteProductReviewUseCase;
  final TokenStorageHelper tokenStorageHelper;

  int _currentProductId = 0;
  int _currentPage = 1;
  bool _showAddReviewSection = true;

  ProductReviewCubit(
    this.getProductReviewsUseCase,
    this.getProductRatingUseCase,
    this.createProductReviewUseCase,
    this.updateProductReviewUseCase,
    this.deleteProductReviewUseCase,
    this.tokenStorageHelper,
  ) : super(const ProductReviewInitial());

  Future<void> loadProductReviews(
    int productId, {
    bool showLoading = true,
    bool showAddReviewSection = true,
  }) async {
    _currentProductId = productId;
    _currentPage = 1;
    _showAddReviewSection = showAddReviewSection;

    if (showLoading) {
      emit(const ProductReviewLoading());
    }

    final reviewsResult = await getProductReviewsUseCase(
      productId: productId,
      pageNumber: 1,
      pageSize: _pageSize,
    );
    final ratingResult = await getProductRatingUseCase(productId);
    final currentUserId = await tokenStorageHelper.getCurrentUserId();

    final ProductReviewPageEntity? page = reviewsResult.fold(
      (failure) => null,
      (value) => value,
    );
    if (page == null) {
      final failure = reviewsResult.fold((failure) => failure, (_) => null);
      emit(
        _buildErrorState(message: failure?.errMessage ?? 'فشل تحميل التقييمات'),
      );
      return;
    }

    final RatingSummaryEntity? ratingSummary = ratingResult.fold(
      (failure) => null,
      (value) => value,
    );
    if (ratingSummary == null) {
      final failure = ratingResult.fold((failure) => failure, (_) => null);
      emit(
        _buildErrorState(
          message: failure?.errMessage ?? 'فشل تحميل ملخص التقييمات',
        ),
      );
      return;
    }

    _currentPage = page.pageNumber;
    final canAddReview =
        _showAddReviewSection &&
        (currentUserId == null ||
            page.items.every((review) => review.userId != currentUserId));

    final contentState = _buildContentState(
      reviews: page.items,
      ratingSummary: ratingSummary,
      hasMore: page.hasMore,
      currentUserId: currentUserId,
      canAddReview: canAddReview,
      showAddReviewSection: _showAddReviewSection,
    );

    if (page.items.isEmpty && ratingSummary.totalReviews == 0) {
      emit(
        ProductReviewEmpty(
          reviews: contentState.reviews,
          ratingSummary: contentState.ratingSummary,
          hasMore: contentState.hasMore,
          showAddReviewSection: contentState.showAddReviewSection,
          canAddReview: contentState.canAddReview,
          currentUserId: contentState.currentUserId,
        ),
      );
      return;
    }

    emit(
      ProductReviewLoaded(
        reviews: contentState.reviews,
        ratingSummary: contentState.ratingSummary,
        hasMore: contentState.hasMore,
        showAddReviewSection: contentState.showAddReviewSection,
        canAddReview: contentState.canAddReview,
        currentUserId: contentState.currentUserId,
      ),
    );
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! ProductReviewContentState || !currentState.hasMore) {
      return;
    }
    if (currentState is ProductReviewLoadingMore) {
      return;
    }

    emit(
      ProductReviewLoadingMore(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
      ),
    );

    final reviewsResult = await getProductReviewsUseCase(
      productId: _currentProductId,
      pageNumber: _currentPage + 1,
      pageSize: _pageSize,
    );

    final currentContent = currentState;
    final nextPage = reviewsResult.fold<ProductReviewPageEntity?>((failure) {
      developer.log(
        'ProductReviewCubit: loadMore failed: ${failure.errMessage}',
        name: 'ProductReviews',
      );
      emit(currentContent);
      return null;
    }, (value) => value);

    if (nextPage == null) {
      return;
    }

    _currentPage = nextPage.pageNumber;
    final mergedReviews = [...currentContent.reviews, ...nextPage.items];
    final canAddReview =
        currentContent.showAddReviewSection &&
        (currentContent.currentUserId == null ||
            mergedReviews.every(
              (review) => review.userId != currentContent.currentUserId,
            ));

    emit(
      ProductReviewLoaded(
        reviews: mergedReviews,
        ratingSummary: currentContent.ratingSummary,
        hasMore: nextPage.hasMore,
        showAddReviewSection: currentContent.showAddReviewSection,
        canAddReview: canAddReview,
        currentUserId: currentContent.currentUserId,
      ),
    );
  }

  Future<void> addReview({required int score, String? comment}) async {
    final currentState = state;
    if (currentState is! ProductReviewContentState) {
      return;
    }

    if (!_isScoreValid(score)) {
      emit(
        _buildErrorState(
          message: 'التقييم يجب أن يكون بين 1 و 5',
          previous: currentState,
        ),
      );
      return;
    }

    if ((comment ?? '').trim().length > 500) {
      emit(
        _buildErrorState(
          message: 'التعليق يجب ألا يتجاوز 500 حرف',
          previous: currentState,
        ),
      );
      return;
    }

    emit(
      AddReviewLoading(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
      ),
    );

    final result = await createProductReviewUseCase(
      productId: _currentProductId,
      score: score,
      comment: comment,
    );

    final success = result.fold((failure) {
      emit(
        _buildErrorState(message: failure.errMessage, previous: currentState),
      );
      return false;
    }, (_) => true);

    if (!success) {
      return;
    }

    emit(
      AddReviewSuccess(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
        message: 'تم إرسال التقييم بنجاح',
      ),
    );

    await loadProductReviews(
      _currentProductId,
      showLoading: false,
      showAddReviewSection: _showAddReviewSection,
    );
  }

  Future<void> updateReview({
    required int reviewId,
    required int score,
    String? comment,
  }) async {
    final currentState = state;
    if (currentState is! ProductReviewContentState) {
      return;
    }

    if (!_isScoreValid(score)) {
      emit(
        _buildErrorState(
          message: 'التقييم يجب أن يكون بين 1 و 5',
          previous: currentState,
        ),
      );
      return;
    }

    if ((comment ?? '').trim().length > 500) {
      emit(
        _buildErrorState(
          message: 'التعليق يجب ألا يتجاوز 500 حرف',
          previous: currentState,
        ),
      );
      return;
    }

    emit(
      UpdateReviewLoading(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
        actionReviewId: reviewId,
      ),
    );

    final result = await updateProductReviewUseCase(
      id: reviewId,
      score: score,
      comment: comment,
    );

    final success = result.fold((failure) {
      emit(
        _buildErrorState(message: failure.errMessage, previous: currentState),
      );
      return false;
    }, (_) => true);

    if (!success) {
      return;
    }

    emit(
      UpdateReviewSuccess(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
        message: 'تم حفظ التعديل',
      ),
    );

    await loadProductReviews(
      _currentProductId,
      showLoading: false,
      showAddReviewSection: _showAddReviewSection,
    );
  }

  Future<void> deleteReview(int reviewId) async {
    final currentState = state;
    if (currentState is! ProductReviewContentState) {
      return;
    }

    emit(
      DeleteReviewLoading(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
        actionReviewId: reviewId,
      ),
    );

    final result = await deleteProductReviewUseCase(reviewId);

    final success = result.fold((failure) {
      emit(
        _buildErrorState(message: failure.errMessage, previous: currentState),
      );
      return false;
    }, (_) => true);

    if (!success) {
      return;
    }

    emit(
      DeleteReviewSuccess(
        reviews: currentState.reviews,
        ratingSummary: currentState.ratingSummary,
        hasMore: currentState.hasMore,
        showAddReviewSection: currentState.showAddReviewSection,
        canAddReview: currentState.canAddReview,
        currentUserId: currentState.currentUserId,
        message: 'تم حذف التقييم',
      ),
    );

    await loadProductReviews(
      _currentProductId,
      showLoading: false,
      showAddReviewSection: _showAddReviewSection,
    );
  }

  bool _isScoreValid(int score) => score >= 1 && score <= 5;

  ProductReviewContentState _buildContentState({
    required List<ProductReviewEntity> reviews,
    required RatingSummaryEntity ratingSummary,
    required bool hasMore,
    required String? currentUserId,
    required bool canAddReview,
    required bool showAddReviewSection,
  }) {
    return ProductReviewLoaded(
      reviews: reviews,
      ratingSummary: ratingSummary,
      hasMore: hasMore,
      showAddReviewSection: showAddReviewSection,
      canAddReview: canAddReview,
      currentUserId: currentUserId,
    );
  }

  ProductReviewError _buildErrorState({
    required String message,
    ProductReviewContentState? previous,
  }) {
    final content = previous ?? _emptyContentState();
    return ProductReviewError(
      reviews: content.reviews,
      ratingSummary: content.ratingSummary,
      hasMore: content.hasMore,
      showAddReviewSection: content.showAddReviewSection,
      canAddReview: content.canAddReview,
      currentUserId: content.currentUserId,
      actionReviewId: content.actionReviewId,
      message: message,
    );
  }

  ProductReviewContentState _emptyContentState() {
    return ProductReviewEmpty(
      reviews: const <ProductReviewEntity>[],
      ratingSummary: RatingSummaryEntity.empty,
      hasMore: false,
      showAddReviewSection: _showAddReviewSection,
      canAddReview: _showAddReviewSection,
      currentUserId: null,
    );
  }
}
