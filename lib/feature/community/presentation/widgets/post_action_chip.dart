import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class PostActionChip extends StatelessWidget {
  final String label;
  final IconData icon;

  const PostActionChip({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.smallSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.smallSecondaryColor),
        ],
      ),
    );
  }
}
