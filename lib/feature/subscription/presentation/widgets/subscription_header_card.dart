import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class SubscriptionHeaderCard extends StatelessWidget {
  const SubscriptionHeaderCard({
    required this.totalPlans,
    required this.pageNumber,
    required this.totalPages,
    super.key,
  });

  final int totalPlans;
  final int pageNumber;
  final int totalPages;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.surfaceVariantColor,
            child: Icon(
              Icons.person_outline,
              color: AppColors.smallSecondaryColor,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المقايضة التجريبية',
                  style: AppStyles.bodyLarge.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'متاح الآن $totalPlans باقة عبر الصفحة $pageNumber من $totalPages',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textMutedColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          CircleAvatar(
            radius: 18.r,
            backgroundColor: const Color(0xFFF3F4FF),
            child: Image.asset(
              AppAssets.transparent,
              width: 18.w,
              height: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}
