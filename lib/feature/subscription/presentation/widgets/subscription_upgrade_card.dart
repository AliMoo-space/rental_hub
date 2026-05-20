import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/subscription/presentation/widgets/subscription_cta_button.dart';

class SubscriptionUpgradeCard extends StatelessWidget {
  const SubscriptionUpgradeCard({
    required this.imageAsset,
    required this.totalPlans,
    super.key,
  });

  final String imageAsset;
  final int totalPlans;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF0EEFF),
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        children: [
          Text(
            'لماذا الترقية الآن؟',
            textAlign: TextAlign.center,
            style: AppStyles.titleMedium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'يوجد الآن $totalPlans باقة متاحة. الخطط الأعلى تمنحك دعم أفضل، ظهور أعلى، وتجربة أكثر مرونة داخل التطبيق.',
            textAlign: TextAlign.center,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _MetricItem(value: '24/7', label: 'دعم فني'),
              _MetricItem(value: '0%', label: 'رسوم خفية'),
            ],
          ),
          SizedBox(height: 18.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.asset(
              imageAsset,
              width: double.infinity,
              height: 180.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 16.h),
          const SubscriptionCtaButton(
            label: 'احجز الآن',
            styleType: SubscriptionButtonStyle.primary,
          ),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: AppStyles.headlineSmall.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(color: AppColors.textMutedColor),
        ),
      ],
    );
  }
}
