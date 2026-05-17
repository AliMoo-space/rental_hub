import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/app_image.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';

class ProductHeaderWidget extends StatelessWidget {
  final ProductDetailsEntity productDetails;

  const ProductHeaderWidget({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300.h,
          decoration: BoxDecoration(color: AppColors.surfaceColor),
          child: AppNetworkImage(images: productDetails.images),
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
                  (productDetails.locationArea.isEmpty)
                      ? 'Unknown location'
                      : productDetails.locationArea,
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
                  '${productDetails.averageRating}',
                  style: AppStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                horizontalSpacing(4),
                Text(
                  '(${productDetails.totalReviews})',
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
