import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class OrderStatusBadge extends StatelessWidget {
  final String status;

  const OrderStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final config = _statusConfig(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status,
        style: AppStyles.bodySmall.copyWith(
          color: config.textColor,
          fontWeight: FontWeight.w600,
          fontSize: 11.sp,
        ),
      ),
    );
  }

  _StatusConfig _statusConfig(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return _StatusConfig(
          backgroundColor: AppColors.warningColor.withValues(alpha: 0.15),
          textColor: AppColors.warningColor,
        );
      case 'approved':
      case 'shipped':
        return _StatusConfig(
          backgroundColor: AppColors.primarySoftColor,
          textColor: AppColors.primaryColor,
        );
      case 'rejected':
      case 'cancelled':
        return _StatusConfig(
          backgroundColor: AppColors.errorColor.withValues(alpha: 0.1),
          textColor: AppColors.errorColor,
        );
      case 'confirmed receipt':
      case 'confirmed':
      case 'delivered':
        return _StatusConfig(
          backgroundColor: AppColors.successColor.withValues(alpha: 0.1),
          textColor: AppColors.successColor,
        );
      case 'returned':
        return _StatusConfig(
          backgroundColor: AppColors.textMutedColor.withValues(alpha: 0.15),
          textColor: AppColors.textSecondaryColor,
        );
      default:
        return _StatusConfig(
          backgroundColor: AppColors.surfaceVariantColor,
          textColor: AppColors.textSecondaryColor,
        );
    }
  }
}

class _StatusConfig {
  final Color backgroundColor;
  final Color textColor;

  const _StatusConfig({required this.backgroundColor, required this.textColor});
}
