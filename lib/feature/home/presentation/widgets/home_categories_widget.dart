import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class HomeCategoriesWidget extends StatelessWidget {
  const HomeCategoriesWidget({
    super.key,
    required this.selectedCategoryIndex,
    required this.onCategorySelected,
  });

  static const List<String> _categories = [
    'الكل',
    'كراسي',
    'طاولات',
    'غرف نوم',
    'مكاتب',
    'ديكور',
  ];

  final int selectedCategoryIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final isSelected = index == selectedCategoryIndex;
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
                      : AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(16.r),
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
                    _categories[index],
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
