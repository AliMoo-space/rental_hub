import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class OrderInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;
  final FontWeight? valueWeight;
  final bool isMultiline;

  const OrderInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
    this.valueWeight,
    this.isMultiline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: isMultiline
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primarySoftColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 18.w, color: AppColors.primaryColor),
        ),
        WidthSpace(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.textMutedColor,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              HeightSpace(2),
              Text(
                value,
                style: AppStyles.bodyMedium.copyWith(
                  color: valueColor ?? AppColors.textPrimaryColor,
                  fontWeight: valueWeight ?? FontWeight.w500,
                  fontSize: 14.sp,
                ),
                maxLines: isMultiline ? 3 : 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderPriceRow extends StatelessWidget {
  final String label;
  final double amount;
  final bool isTotal;
  final String? currency;

  const OrderPriceRow({
    super.key,
    required this.label,
    required this.amount,
    this.isTotal = false,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppStyles.bodyMedium.copyWith(
              color: isTotal
                  ? AppColors.textPrimaryColor
                  : AppColors.textSecondaryColor,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              fontSize: isTotal ? 16.sp : 14.sp,
            ),
          ),
          Text(
            '${amount.toStringAsFixed(2)} ${currency ?? l10n.egp}',
            style: AppStyles.bodyMedium.copyWith(
              color: isTotal
                  ? AppColors.primaryColor
                  : AppColors.textPrimaryColor,
              fontWeight: isTotal ? FontWeight.w700 : FontWeight.w500,
              fontSize: isTotal ? 16.sp : 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const OrderSectionHeader({super.key, required this.title, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppStyles.bodyLarge.copyWith(fontWeight: FontWeight.w700),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class OrderSectionContainer extends StatelessWidget {
  final Widget child;

  const OrderSectionContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [AppShadows.softCard],
      ),
      child: child,
    );
  }
}
