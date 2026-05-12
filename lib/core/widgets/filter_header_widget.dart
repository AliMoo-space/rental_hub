import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class FilterHeaderWidget extends StatelessWidget {
  final String title;
  final String selectedFilter;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  const FilterHeaderWidget({
    super.key,
    required this.title,
    required this.selectedFilter,
    required this.onSearchTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // right side: title
        Expanded(
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              title,
              textAlign: TextAlign.right,
              style: AppStyles.hendi500Size20,
            ),
          ),
        ),
        // left side: search + filter
        Row(
          children: [
            _IconPill(icon: Icons.search_rounded, onTap: onSearchTap),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: onFilterTap,
              child: SizedBox(
                width: 110.w,
                child: _FilterPill(
                  label: selectedFilter,
                  trailing: Icons.keyboard_arrow_down_rounded,
                  leading: Icons.calendar_month_rounded,
                  isCompact: false,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _IconPill extends StatelessWidget {
  const _IconPill({required this.icon, required this.onTap});

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

class _FilterPill extends StatelessWidget {
  const _FilterPill({
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
          Icon(leading, size: 18.sp, color: AppColors.smallSecondaryColor),
          SizedBox(width: 8.w),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerEnd,
              child: Text(
                label,
                textAlign: TextAlign.right,
                maxLines: 1,
                style: AppStyles.instrumentSans500Size14.copyWith(
                  color: AppColors.smallSecondaryColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Icon(trailing, size: 20.sp, color: AppColors.smallSecondaryColor),
        ],
      ),
    );
  }
}
