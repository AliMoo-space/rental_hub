import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class RatingBarWidget extends StatelessWidget {
  final int star;
  final int count;
  final int totalCount;

  const RatingBarWidget({
    super.key,
    required this.star,
    required this.count,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = totalCount == 0 ? 0.0 : count / totalCount;

    return Row(
      children: [
        SizedBox(
          width: 40.w,
          child: Text(
            '$star★',
            style: AppStyles.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 10.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceVariantColor,
              borderRadius: BorderRadius.circular(999.r),
            ),
            child: FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: percentage,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(999.r),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 34.w,
          child: Text(
            '$count',
            textAlign: TextAlign.end,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
