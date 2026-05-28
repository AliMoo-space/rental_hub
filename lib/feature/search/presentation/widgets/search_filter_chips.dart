import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class SearchFilterChips extends StatelessWidget {
  final List<String> categories;
  final void Function(String) onCategorySelected;
  const SearchFilterChips({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((c) {
          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: FilterChip(
              label: Text(c),
              selected: false,
              onSelected: (_) => onCategorySelected(c),
              labelStyle: AppStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
              backgroundColor: AppColors.surfaceColor,
              selectedColor: AppColors.primarySoftColor.withValues(alpha: 0.22),
              side: const BorderSide(color: AppColors.borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.r),
              ),
              showCheckmark: false,
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            ),
          );
        }).toList(),
      ),
    );
  }
}
