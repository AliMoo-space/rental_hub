import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Individual insurance option card with selection capability
class InsuranceOptionWidget extends StatelessWidget {
  final String insuranceTitle;
  final String insuranceDescription;
  final double monthlyPrice;
  final double deductiblePrice;
  final double servicePrice;
  final double totalPrice;
  final bool isSelected;
  final VoidCallback onSelect;
  final IconData? icon;

  const InsuranceOptionWidget({
    super.key,
    required this.insuranceTitle,
    required this.insuranceDescription,
    required this.monthlyPrice,
    required this.deductiblePrice,
    required this.servicePrice,
    required this.totalPrice,
    required this.isSelected,
    required this.onSelect,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and title
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.w,
                  decoration: BoxDecoration(
                    color: AppColors.primarySoftColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon ?? Icons.shield_outlined,
                    color: AppColors.primaryColor,
                    size: 20.w,
                  ),
                ),
                const WidthSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insuranceTitle,
                        style: AppStyles.bodyLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const HeightSpace(2),
                      Text(
                        insuranceDescription,
                        style: AppStyles.bodySmall.copyWith(
                          color: AppColors.textSecondaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Selection checkbox
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? AppColors.primaryColor
                        : AppColors.surfaceVariantColor,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.borderColor,
                      width: 2,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14.w,
                          ),
                        )
                      : null,
                ),
              ],
            ),
            const HeightSpace(16),
            // Pricing breakdown
            _PricingRow(label: 'قيمة التأمين الأساسي', price: monthlyPrice),
            const HeightSpace(8),
            _PricingRow(label: 'رسوم حماية الضمان', price: deductiblePrice),
            const HeightSpace(8),
            _PricingRow(label: 'رسوم الخدمة', price: servicePrice),
            const HeightSpace(12),
            Divider(color: AppColors.borderColor, height: 1),
            const HeightSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'إجمالي رسوم التأمين',
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'ج.م ${totalPrice.toStringAsFixed(0)}',
                  style: AppStyles.bodyLarge.copyWith(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PricingRow extends StatelessWidget {
  final String label;
  final double price;

  const _PricingRow({required this.label, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryColor,
          ),
        ),
        Text(
          'ج.م ${price.toStringAsFixed(0)}',
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
