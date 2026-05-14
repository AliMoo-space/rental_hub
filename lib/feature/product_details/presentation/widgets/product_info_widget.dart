import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Product info section with title and pricing details
class ProductInfoWidget extends StatelessWidget {
  final String productName;
  final double rentalPrice;
  final String rentalPeriod;

  const ProductInfoWidget({
    super.key,
    required this.productName,
    required this.rentalPrice,
    this.rentalPeriod = 'per day',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  productName,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.favorite_outline,
                color: AppColors.primaryColor,
                size: 24.w,
              ),
            ],
          ),
          verticalSpacing(12),
          Row(
            children: [
              Text(
                'ج.م ${rentalPrice.toStringAsFixed(0)}',
                style: AppStyles.displayMedium.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              horizontalSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rentalPeriod,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  verticalSpacing(4),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariantColor,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Text(
                      'مستعمل',
                      style: AppStyles.labelSmall.copyWith(
                        fontSize: 9.sp,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
