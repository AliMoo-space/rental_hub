import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Product header with image, location badge, and rating
class ProductHeaderWidget extends StatelessWidget {
  final String imageUrl;
  final String location;
  final double rating;
  final int reviewCount;

  const ProductHeaderWidget({
    super.key,
    required this.imageUrl,
    required this.location,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Product Image
        Container(
          width: double.infinity,
          height: 300.h,
          decoration: BoxDecoration(color: AppColors.surfaceColor),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: AppColors.surfaceVariantColor,
              child: const Icon(Icons.image_not_supported),
            ),
          ),
        ),
        // Location Badge
        Positioned(
          bottom: 16.h,
          left: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.w,
                  color: AppColors.primaryColor,
                ),
                horizontalSpacing(4),
                Text(
                  location,
                  style: AppStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Rating Badge
        Positioned(
          bottom: 16.h,
          right: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star_rounded,
                  size: 14.w,
                  color: AppColors.primaryColor,
                ),
                horizontalSpacing(4),
                Text(
                  '$rating',
                  style: AppStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                horizontalSpacing(4),
                Text(
                  '($reviewCount)',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
