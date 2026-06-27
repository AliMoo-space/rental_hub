import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class ProfileErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryLabel;

  const ProfileErrorState({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: AppColors.errorColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 36.sp,
                color: AppColors.errorColor,
              ),
            ),
            HeightSpace(20),
            Text(
              message,
              style: AppStyles.bodyLarge,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              HeightSpace(24),
              PrimaryButtonWidget(
                buttonText: retryLabel ?? 'Retry',
                onPress: onRetry,
                width: 160.w,
                height: 44.h,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
