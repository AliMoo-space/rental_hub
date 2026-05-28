import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

/// Compact reviews summary entry point for product details.
class ReviewsWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onViewAllReviews;

  const ReviewsWidget({
    super.key,
    required this.product,
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
              // if (reviews.isNotEmpty)
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
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Row(
              children: [
                Container(
                  width: 72.w,
                  height: 72.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      product.averageRating.toStringAsFixed(1),
                      style: AppStyles.titleMedium.copyWith(
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
                        product.totalReviews == 0
                            ? 'لا توجد تقييمات بعد'
                            : 'متوسط ${product.averageRating.toStringAsFixed(1)} من 5',
                        style: AppStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      verticalSpacing(4),
                      Text(
                        '${product.totalReviews} تقييم',
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: AppColors.primaryColor,
                  size: 16.w,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
