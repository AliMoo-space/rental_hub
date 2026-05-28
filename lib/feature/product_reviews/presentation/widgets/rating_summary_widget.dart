import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_reviews/domain/entities/rating_summary_entity.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/rating_bar_widget.dart';
import 'package:rental_hub/feature/product_reviews/presentation/widgets/star_selector_widget.dart';

class RatingSummaryWidget extends StatelessWidget {
  final RatingSummaryEntity ratingSummary;

  const RatingSummaryWidget({super.key, required this.ratingSummary});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 92.w,
                height: 92.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.08),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    ratingSummary.averageRating.toStringAsFixed(1),
                    style: AppStyles.headlineMedium.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              horizontalSpacing(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'متوسط التقييم',
                      style: AppStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    verticalSpacing(8),
                    StarSelectorWidget(
                      rating: ratingSummary.averageRating,
                      readOnly: true,
                    ),
                    verticalSpacing(8),
                    Text(
                      '${ratingSummary.totalReviews} تقييم',
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpacing(20),
          ...List.generate(5, (index) {
            final star = 5 - index;
            return Padding(
              padding: EdgeInsets.only(bottom: index == 4 ? 0 : 12.h),
              child: RatingBarWidget(
                star: star,
                count: ratingSummary.countFor(star),
                totalCount: ratingSummary.totalReviews,
              ),
            );
          }),
        ],
      ),
    );
  }
}
