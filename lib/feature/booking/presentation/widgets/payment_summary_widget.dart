import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Payment summary widget showing pricing breakdown
class PaymentSummaryWidget extends StatelessWidget {
  final double rentalPrice;
  final double insurancePrice;
  final double servicePrice;
  final double totalPrice;

  const PaymentSummaryWidget({
    super.key,
    required this.rentalPrice,
    required this.insurancePrice,
    required this.servicePrice,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primarySoftColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تفاصيل الفاتورة',
            style: AppStyles.bodyLarge.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimaryColor,
            ),
          ),
          const HeightSpace(16),
          _SummaryRow(label: 'رسوم الإيجار', price: rentalPrice),
          const HeightSpace(12),
          _SummaryRow(label: 'صافي التأمين', price: insurancePrice),
          const HeightSpace(12),
          _SummaryRow(label: 'رسوم الخدمة', price: servicePrice),
          const HeightSpace(16),
          Divider(color: AppColors.borderColor, height: 1),
          const HeightSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إجمالي رسوم التأمين',
                style: AppStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                ),
              ),
              Text(
                'ج.م ${totalPrice.toStringAsFixed(0)}',
                style: AppStyles.headlineSmall.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final double price;

  const _SummaryRow({required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.textSecondaryColor,
          ),
        ),
        Text(
          'ج.م ${price.toStringAsFixed(0)}',
          style: AppStyles.bodyMedium.copyWith(
            color: AppColors.textPrimaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
