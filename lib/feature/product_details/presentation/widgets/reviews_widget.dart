import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Reviews section showing customer reviews with ratings
class ReviewsWidget extends StatelessWidget {
  final List<Review> reviews;
  final VoidCallback? onViewAllReviews;

  const ReviewsWidget({
    super.key,
    required this.reviews,
    this.onViewAllReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'التعليقات',
                style: AppStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (reviews.isNotEmpty)
                GestureDetector(
                  onTap: onViewAllReviews,
                  child: Text(
                    'عرض الكل',
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          verticalSpacing(12),
          if (reviews.isEmpty)
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: Text(
                  'لا توجد تعليقات بعد',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.textMutedColor,
                  ),
                ),
              ),
            )
          else
            Column(
              children: List.generate(
                reviews.length > 2 ? 2 : reviews.length,
                (index) => Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: _ReviewCard(review: reviews[index]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final Review review;

  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Reviewer header
          Row(
            children: [
              CircleAvatar(
                radius: 20.w,
                backgroundImage: NetworkImage(review.reviewerImage),
                onBackgroundImageError: (_, __) => const Icon(Icons.person),
              ),
              horizontalSpacing(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.reviewerName,
                      style: AppStyles.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    verticalSpacing(2),
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Icon(
                            index < review.rating.toInt()
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: AppColors.primaryColor,
                            size: 12.w,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          // Review text
          Text(
            review.reviewText,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              height: 1.5,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class Review {
  final String reviewerName;
  final String reviewerImage;
  final double rating;
  final String reviewText;

  Review({
    required this.reviewerName,
    required this.reviewerImage,
    required this.rating,
    required this.reviewText,
  });
}
