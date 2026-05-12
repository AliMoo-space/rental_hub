import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class PickerField extends StatelessWidget {
  const PickerField({required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 14.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Text(
            hintText,
            textAlign: TextAlign.start,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.smallSecondaryColor,
              fontSize: 13.sp,
            ),
          ),
          const Spacer(),

          SizedBox(width: 8.w),
          Icon(
            Icons.chevron_right,
            color: AppColors.smallSecondaryColor,
            size: 22.sp,
          ),
        ],
      ),
    );
  }
}
