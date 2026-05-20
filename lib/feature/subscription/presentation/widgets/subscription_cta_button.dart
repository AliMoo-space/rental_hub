import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

enum SubscriptionButtonStyle { primary, secondary, ghost }

class SubscriptionCtaButton extends StatelessWidget {
  const SubscriptionCtaButton({
    required this.label,
    required this.styleType,
    this.onPressed,
    super.key,
  });

  final String label;
  final SubscriptionButtonStyle styleType;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final isGhost = styleType == SubscriptionButtonStyle.ghost;
    final backgroundColor = switch (styleType) {
      SubscriptionButtonStyle.primary => AppColors.primaryColor,
      SubscriptionButtonStyle.secondary => const Color(0xff6F75FF),
      SubscriptionButtonStyle.ghost => Colors.transparent,
    };

    final foregroundColor = isGhost
        ? AppColors.primaryColor
        : AppColors.whiteColor;

    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          side: isGhost
              ? const BorderSide(color: AppColors.primaryColor, width: 1.2)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999.r),
          ),
        ),
        child: Text(
          label,
          style: AppStyles.buttonLabel.copyWith(color: foregroundColor),
        ),
      ),
    );
  }
}
