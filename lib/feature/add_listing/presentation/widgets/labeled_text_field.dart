import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.titleMedium.copyWith(
            color: isDarkMode
                ? AppColors.textMutedColor
                : AppColors.secondaryColor,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 10.h),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          cursorColor: AppColors.primaryColor,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.bodyMedium.copyWith(
              color: isDarkMode
                  ? AppColors.textMutedColor
                  : AppColors.smallSecondaryColor,
            ),
            filled: true,
            fillColor: isDarkMode ? const Color(0xFF111827) : Colors.white,
            contentPadding: EdgeInsetsDirectional.symmetric(
              horizontal: 14.w,
              vertical: 14.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDarkMode
                    ? const Color(0xFF334155)
                    : AppColors.borderColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: isDarkMode
                    ? const Color(0xFF334155)
                    : AppColors.borderColor,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
