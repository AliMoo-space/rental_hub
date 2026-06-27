import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/app_image.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class ProductHeaderWidget extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback? onFavoritePressed;
  final bool isFavoriteLoading;

  const ProductHeaderWidget({
    super.key,
    required this.product,
    this.onFavoritePressed,
    this.isFavoriteLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 300.h,
          decoration: BoxDecoration(color: Colors.transparent),
          child: AppNetworkImage(
            images: product.images,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        // Favorite Button
        Positioned(
          top: 16.h,
          right: 16.w,
          child: GestureDetector(
            onTap: isFavoriteLoading ? null : onFavoritePressed,
            child: CircleAvatar(
              radius: 18.r,
              backgroundColor: const Color(0xffFFFFFF).withValues(alpha: .8),
              child: isFavoriteLoading
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Icon(
                      product.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: product.isFavorite
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                      size: 20.sp,
                    ),
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
                  (product.locationArea.isEmpty)
                      ? 'Unknown location'
                      : product.locationArea,
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
                  '${product.averageRating}',
                  style: AppStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                horizontalSpacing(4),
                Text(
                  '(${product.totalReviews})',
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
