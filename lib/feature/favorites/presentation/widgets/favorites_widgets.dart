import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class IconPill extends StatelessWidget {
  const IconPill({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        borderRadius: BorderRadius.circular(14.r),
        onTap: onTap,
        child: Container(
          width: 54.w,
          height: 42.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Icon(icon, size: 22.sp, color: AppColors.smallSecondaryColor),
        ),
      ),
    );
  }
}

class FilterPill extends StatelessWidget {
  const FilterPill({
    required this.label,
    required this.trailing,
    required this.leading,
    required this.isCompact,
  });

  final String label;
  final IconData trailing;
  final IconData leading;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isCompact ? 34.h : 42.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(leading, size: 20.sp, color: AppColors.smallSecondaryColor),
          WidthSpace(8),
          Expanded(
            child: Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                label,
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
                style: AppStyles.instrumentSans500Size14.copyWith(
                  color: AppColors.smallSecondaryColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          WidthSpace(4),
          Icon(trailing, size: 20.sp, color: AppColors.smallSecondaryColor),
        ],
      ),
    );
  }
}
