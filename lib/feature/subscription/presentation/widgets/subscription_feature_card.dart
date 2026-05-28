import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/subscription/domain/entities/subscription_entity.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_cta_button.dart';

class SubscriptionFeatureCard extends StatelessWidget {
  const SubscriptionFeatureCard({
    required this.plan,
    required this.accentColor,
    required this.buttonLabel,
    required this.buttonStyle,
    this.onPressed,
    this.isBusy = false,
    this.isHighlighted = false,
    super.key,
  });

  final SubscriptionPlanEntity plan;
  final Color accentColor;
  final String buttonLabel;
  final SubscriptionButtonStyle buttonStyle;
  final VoidCallback? onPressed;
  final bool isBusy;
  final bool isHighlighted;

  String _formatPrice(double price) {
    final formatted = price.toStringAsFixed(2);
    return formatted.endsWith('.00')
        ? formatted.substring(0, formatted.length - 3)
        : formatted;
  }

  String _formatMaxProducts(int maxProducts) {
    if (maxProducts <= 0) return 'منتجات غير محدودة';
    return 'حتى $maxProducts منتج';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: isHighlighted
              ? accentColor
              : accentColor.withValues(alpha: 0.55),
          width: isHighlighted ? 2.2 : 1.6,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.08),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      plan.name,
                      style: AppStyles.titleMedium.copyWith(color: accentColor),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${_formatPrice(plan.price)} ج.م · ${plan.durationDays} يوم · ${_formatMaxProducts(plan.maxProducts)}',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.textMutedColor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatPrice(plan.price),
                    style: AppStyles.headlineSmall.copyWith(
                      color: AppColors.textPrimaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'ج.م / ${plan.durationDays} يوم',
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textMutedColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...plan.features.map(
            (feature) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.w,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.uiVector,
                        width: 12.w,
                        height: 12.w,
                        colorFilter: ColorFilter.mode(
                          accentColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      feature,
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),
          SubscriptionCtaButton(
            label: buttonLabel,
            styleType: buttonStyle,
            onPressed: onPressed,
            isBusy: isBusy,
          ),
        ],
      ),
    );
  }
}
