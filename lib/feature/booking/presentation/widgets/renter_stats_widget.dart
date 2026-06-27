import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';

class RenterStatsWidget extends StatelessWidget {
  final RentalOrderStatsEntity stats;

  const RenterStatsWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.activeRentals,
              style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
            ),
            HeightSpace(16),
            Row(
              children: [
                _StatItem(
                  label: context.l10n.activeRentals,
                  value: stats.activeOrders.toString(),
                  color: AppColors.primaryColor,
                  icon: Icons.shopping_bag_rounded,
                ),
                _StatDivider(),
                _StatItem(
                  label: context.l10n.statusLabel,
                  value: stats.pendingOrders.toString(),
                  color: AppColors.warningColor,
                  icon: Icons.hourglass_empty_rounded,
                ),
              ],
            ),
            HeightSpace(12),
            Row(
              children: [
                _StatItem(
                  label: context.l10n.orderApproved,
                  value: stats.completedOrders.toString(),
                  color: AppColors.successColor,
                  icon: Icons.check_circle_rounded,
                ),
                _StatDivider(),
                _StatItem(
                  label: context.l10n.cancelledLabel,
                  value: stats.cancelledOrders.toString(),
                  color: AppColors.textMutedColor,
                  icon: Icons.cancel_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.w),
          ),
          HeightSpace(8),
          Text(
            value,
            style: AppStyles.titleMedium.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      color: AppColors.borderColor,
    );
  }
}
