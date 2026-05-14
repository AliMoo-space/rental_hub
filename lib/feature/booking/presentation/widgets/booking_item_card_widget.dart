import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Shows the product being booked with image, name, location, and rating
class BookingItemCardWidget extends StatelessWidget {
  final String productName;
  final String location;
  final double rating;
  final int reviewCount;
  final String imageUrl;
  final bool isAvailable;

  const BookingItemCardWidget({
    super.key,
    required this.productName,
    required this.location,
    required this.rating,
    required this.reviewCount,
    required this.imageUrl,
    this.isAvailable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          // Product Image
          ClipRoundedRectangle(
            radius: 8.r,
            child: Container(
              width: 80.w,
              height: 80.w,
              color: AppColors.surfaceColor,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceVariantColor,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          ),
          const WidthSpace(12),
          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpacing(4),
                Text(
                  location,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                verticalSpacing(8),
                Row(
                  children: [
                    // Stars
                    Row(
                      children: List.generate(
                        5,
                        (index) => Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Icon(
                            index < rating.toInt()
                                ? Icons.star_rounded
                                : Icons.star_outline_rounded,
                            color: AppColors.primaryColor,
                            size: 14.w,
                          ),
                        ),
                      ),
                    ),
                    const WidthSpace(4),
                    Text(
                      '$rating',
                      style: AppStyles.labelSmall.copyWith(fontSize: 10.sp),
                    ),
                    const WidthSpace(4),
                    Text(
                      '($reviewCount)',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.textMutedColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ClipRoundedRectangle extends StatelessWidget {
  final Widget child;
  final double radius;

  const ClipRoundedRectangle({
    super.key,
    required this.child,
    required this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
  }
}
