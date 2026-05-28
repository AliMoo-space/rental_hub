import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class WalletCardPreview extends StatelessWidget {
  const WalletCardPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        children: [
          Container(
            height: 132.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0B8FA1), Color(0xFF5FBFC3)],
              ),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  top: 12,
                  child: Container(
                    width: 118.w,
                    height: 96.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fincard',
                                style: AppStyles.bodySmall.copyWith(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Icon(
                                Icons.credit_card_rounded,
                                color: AppColors.whiteColor,
                                size: 22.sp,
                              ),
                            ],
                          ),
                          Text(
                            'Platinum Debit',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        '**** 4839 9473 3038',
                        style: AppStyles.instrumentSans700Size18.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.8,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Valid thru 04/16',
                            style: AppStyles.bodySmall.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                          Text(
                            'VISA',
                            style: AppStyles.titleMedium.copyWith(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            height: 44.h,
            decoration: BoxDecoration(
              color: const Color(0xFFD7D8FF),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.add, color: AppColors.whiteColor),
          ),
          SizedBox(height: 6.h),
          Text(
            'إضافة بطاقة جديدة',
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
