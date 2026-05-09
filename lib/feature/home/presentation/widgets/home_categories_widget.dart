import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  final List<String> categories;

  final int selectedCategoryIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final safeSelectedIndex = selectedCategoryIndex < categories.length
              ? selectedCategoryIndex
              : 0;
          final isSelected = index == safeSelectedIndex;
          return Container(
            margin: EdgeInsetsDirectional.only(end: 10.w),
            child: InkWell(
              borderRadius: BorderRadius.circular(30.r),
              onTap: () => onCategorySelected(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOut,
                padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.borderColor,
                  ),
                  boxShadow: [
                    if (isSelected)
                      BoxShadow(
                        color: AppColors.smallSecondaryColor.withValues(
                          alpha: .2,
                        ),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                  ],
                ),
                child: Center(
                  child: Text(
                    categories[index],
                    style: AppStyles.intro16medium.copyWith(
                      fontSize: 13.sp,
                      color: isSelected
                          ? Colors.white
                          : AppColors.smallSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
