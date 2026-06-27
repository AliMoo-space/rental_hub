import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class InfoTag extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoTag({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF0EEFF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.smallSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
