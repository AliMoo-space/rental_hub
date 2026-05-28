import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';

abstract class ProductReviewState extends Equatable {
  const ProductReviewState();

  @override
  List<Object?> get props => [];
}

class ProductReviewInitial extends ProductReviewState {
  const ProductReviewInitial();
}

class ProductReviewLoading extends ProductReviewState {
  const ProductReviewLoading();
}

abstract class ProductReviewContentState extends ProductReviewState {
  final List<ProductReviewEntity> reviews;
  final RatingSummaryEntity ratingSummary;
  final bool hasMore;
  final bool showAddReviewSection;
  final bool canAddReview;
  final String? currentUserId;
  final int? actionReviewId;
  final String? message;

  const ProductReviewContentState({
    required this.reviews,
    required this.ratingSummary,
    required this.hasMore,
    required this.showAddReviewSection,
    required this.canAddReview,
    required this.currentUserId,
    this.actionReviewId,
    this.message,
  });

  @override
  List<Object?> get props => [
    reviews,
    ratingSummary,
    hasMore,
    showAddReviewSection,
    canAddReview,
    currentUserId,
    actionReviewId,
    message,
  ];
}

class ProductReviewLoaded extends ProductReviewContentState {
  const ProductReviewLoaded({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class ProductReviewEmpty extends ProductReviewContentState {
  const ProductReviewEmpty({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class ProductReviewLoadingMore extends ProductReviewContentState {
  const ProductReviewLoadingMore({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class AddReviewLoading extends ProductReviewContentState {
  const AddReviewLoading({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class AddReviewSuccess extends ProductReviewContentState {
  const AddReviewSuccess({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class UpdateReviewLoading extends ProductReviewContentState {
  const UpdateReviewLoading({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class UpdateReviewSuccess extends ProductReviewContentState {
  const UpdateReviewSuccess({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class DeleteReviewLoading extends ProductReviewContentState {
  const DeleteReviewLoading({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class DeleteReviewSuccess extends ProductReviewContentState {
  const DeleteReviewSuccess({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}

class ProductReviewError extends ProductReviewContentState {
  const ProductReviewError({
    required super.reviews,
    required super.ratingSummary,
    required super.hasMore,
    required super.showAddReviewSection,
    required super.canAddReview,
    required super.currentUserId,
    super.actionReviewId,
    super.message,
  });
}
