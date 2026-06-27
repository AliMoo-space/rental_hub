import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class OrderSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const OrderSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: context.l10n.searchHint,
          hintStyle: AppStyles.bodyMedium.copyWith(
            color: AppColors.textMutedColor,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.textMutedColor,
            size: 20.sp,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.close_rounded, size: 18.sp),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                  },
                )
              : null,
          filled: true,
          fillColor: AppColors.surfaceColor,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
