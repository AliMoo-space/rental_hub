import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class DealsFilterChip extends StatelessWidget {
  const DealsFilterChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_month_rounded,
            size: 18.sp,
            color: AppColors.smallSecondaryColor,
          ),
          WidthSpace(8),
          Text(
            label,
            style: AppStyles.instrumentSans500Size14.copyWith(
              color: AppColors.smallSecondaryColor,
              fontSize: 13.sp,
            ),
          ),
          WidthSpace(4),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 20.sp,
            color: AppColors.smallSecondaryColor,
          ),
        ],
      ),
    );
  }
}
