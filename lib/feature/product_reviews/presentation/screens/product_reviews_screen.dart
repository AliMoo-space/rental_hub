import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/product_review_entity.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_cubit.dart';
import 'package:rental_hub/feature/product_reviews/presentation/cubit/product_review_state.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/add_review_widget.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/edit_review_bottom_sheet.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/rating_summary_widget.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/review_card_widget.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/review_loading_shimmer.dart';

class ProductReviewsScreen extends StatefulWidget {
  final int productId;

  const ProductReviewsScreen({super.key, required this.productId});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductReviewCubit, ProductReviewState>(
      listener: (context, state) {
        if (state is AddReviewSuccess ||
            state is UpdateReviewSuccess ||
            state is DeleteReviewSuccess) {
          final message = state is AddReviewSuccess
              ? state.message
              : state is UpdateReviewSuccess
              ? state.message
              : state is DeleteReviewSuccess
              ? state.message
              : null;
          showMsg(message, context);
        }
        if (state is ProductReviewError) {
          showMsg(state.message, context, isError: true);
        }
      },
      builder: (context, state) {
        final contentState = state is ProductReviewContentState ? state : null;

        return Scaffold(
          backgroundColor: AppColors.surfaceColor,
          appBar: AppBar(
            backgroundColor: AppColors.whiteColor,
            surfaceTintColor: Colors.transparent,
            title: Text(
              'التقييمات',
              style: AppStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          body: state is ProductReviewLoading || state is ProductReviewInitial
              ? const ReviewLoadingShimmer()
              : contentState == null
              ? const ReviewLoadingShimmer()
              : CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                      sliver: SliverToBoxAdapter(
                        child: RatingSummaryWidget(
                          ratingSummary: contentState.ratingSummary,
                        ),
                      ),
                    ),
                    if (contentState.showAddReviewSection &&
                        contentState.canAddReview)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                        sliver: SliverToBoxAdapter(
                          child: AddReviewWidget(
                            isLoading: state is AddReviewLoading,
                            onSubmit: (input) {
                              context.read<ProductReviewCubit>().addReview(
                                score: input.score,
                                comment: input.comment,
                              );
                            },
                          ),
                        ),
                      ),
                    if (contentState.reviews.isEmpty)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(24.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(24.r),
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.rate_review_outlined,
                                  size: 40.sp,
                                  color: AppColors.primaryColor,
                                ),
                                verticalSpacing(12),
                                Text(
                                  'لا توجد تقييمات بعد',
                                  style: AppStyles.bodyLarge.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                verticalSpacing(6),
                                Text(
                                  'كن أول من يشارك رأيه حول هذا المنتج',
                                  textAlign: TextAlign.center,
                                  style: AppStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    else
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 24.h),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            final review = contentState.reviews[index];
                            final isOwner =
                                review.userId == contentState.currentUserId;

                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: index == contentState.reviews.length - 1
                                    ? 0
                                    : 14.h,
                              ),
                              child: ReviewCardWidget(
                                review: review,
                                isOwner: isOwner,
                                isEditLoading:
                                    state is UpdateReviewLoading &&
                                    state.actionReviewId == review.id,
                                isDeleteLoading:
                                    state is DeleteReviewLoading &&
                                    state.actionReviewId == review.id,
                                onEdit: isOwner
                                    ? () => _showEditBottomSheet(
                                        review,
                                        context.read<ProductReviewCubit>(),
                                      )
                                    : null,
                                onDelete: isOwner
                                    ? () => _showDeleteConfirmation(review)
                                    : null,
                              ),
                            );
                          }, childCount: contentState.reviews.length),
                        ),
                      ),
                    if (state is ProductReviewLoadingMore)
                      SliverPadding(
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                        sliver: SliverToBoxAdapter(
                          child: Container(
                            padding: EdgeInsets.all(20.w),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ),
                      ),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  ],
                ),
        );
      },
    );
  }

  void _onScroll() {
    if (!_scrollController.hasClients) {
      return;
    }
    if (_scrollController.position.extentAfter < 280) {
      context.read<ProductReviewCubit>().loadMore();
    }
  }

  void _showEditBottomSheet(
    ProductReviewEntity review,
    ProductReviewCubit cubit,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return EditReviewBottomSheet(review: review, cubit: cubit);
      },
    );
  }

  Future<void> _showDeleteConfirmation(ProductReviewEntity review) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('حذف التقييم'),
          content: const Text('هل تريد حذف هذا التقييم نهائياً؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('إلغاء'),
            ),
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );

    if (confirmed == true && mounted) {
      context.read<ProductReviewCubit>().deleteReview(review.id);
    }
  }
}
