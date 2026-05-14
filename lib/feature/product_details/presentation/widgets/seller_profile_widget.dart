import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Seller/Owner profile section
class SellerProfileWidget extends StatelessWidget {
  final String sellerName;
  final double sellerRating;
  final String sellerLocation;
  final String sellerImage;
  final bool isVerified;

  const SellerProfileWidget({
    super.key,
    required this.sellerName,
    required this.sellerRating,
    required this.sellerLocation,
    required this.sellerImage,
    this.isVerified = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          // Seller Avatar
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderColor, width: 2),
            ),
            child: ClipOval(
              child: Image.network(
                sellerImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceVariantColor,
                  child: const Icon(Icons.person),
                ),
              ),
            ),
          ),
          horizontalSpacing(12),
          // Seller Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      sellerName,
                      style: AppStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isVerified) ...[
                      horizontalSpacing(6),
                      Icon(
                        Icons.verified,
                        color: AppColors.successColor,
                        size: 16.w,
                      ),
                    ],
                  ],
                ),
                verticalSpacing(4),
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: AppColors.primaryColor,
                      size: 14.w,
                    ),
                    horizontalSpacing(4),
                    Text(
                      '$sellerRating',
                      style: AppStyles.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                verticalSpacing(4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.textSecondaryColor,
                      size: 14.w,
                    ),
                    horizontalSpacing(4),
                    Text(
                      sellerLocation,
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Profile Link
          GestureDetector(
            onTap: () {
              // Navigate to seller profile
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColors.surfaceColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor,
                size: 16.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
