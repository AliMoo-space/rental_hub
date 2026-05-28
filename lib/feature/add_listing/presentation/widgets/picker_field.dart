import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class PickerField extends StatelessWidget {
  const PickerField({
    required this.hintText,
    this.value,
    this.onTap,
    this.enabled = true,
    super.key,
  });

  final String hintText;
  final String? value;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final displayedText = value?.trim().isNotEmpty == true ? value! : hintText;

    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Text(
              displayedText,
              textAlign: TextAlign.start,
              style: AppStyles.bodyMedium.copyWith(
                color: enabled
                    ? value?.trim().isNotEmpty == true
                          ? AppColors.secondaryColor
                          : AppColors.smallSecondaryColor
                    : AppColors.smallSecondaryColor.withValues(alpha: .6),
                fontSize: 13.sp,
              ),
            ),
            const Spacer(),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right,
              color: enabled
                  ? AppColors.smallSecondaryColor
                  : AppColors.smallSecondaryColor.withValues(alpha: .6),
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
