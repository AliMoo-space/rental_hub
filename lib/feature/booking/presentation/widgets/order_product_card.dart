import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_status_badge.dart';

class OrderProductCard extends StatelessWidget {
  final RentalOrderEntity order;
  final VoidCallback? onTap;

  const OrderProductCard({super.key, required this.order, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [AppShadows.softCard],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 80.w,
                  height: 80.w,
                  color: AppColors.surfaceColor,
                  child: order.productImage.isNotEmpty
                      ? Image.network(
                          order.productImage,
                          width: 80.w,
                          height: 80.w,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => _placeholder(),
                        )
                      : _placeholder(),
                ),
              ),
              WidthSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName.isNotEmpty
                          ? order.productName
                          : 'Product #${order.productId}',
                      style: AppStyles.bodyLarge.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 16.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    HeightSpace(8),
                    Row(
                      children: [
                        OrderStatusBadge(status: order.status),
                        const Spacer(),
                        Text(
                          '${order.rentalDays} ${context.l10n.dayLabel}',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(12),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_rounded,
                          size: 14.w,
                          color: AppColors.textMutedColor,
                        ),
                        WidthSpace(6),
                        Text(
                          '${_formatDate(order.startDate)} - ${_formatDate(order.endDate)}',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_outlined,
                          size: 14.w,
                          color: AppColors.textMutedColor,
                        ),
                        WidthSpace(6),
                        Text(
                          order.deliveryMethod.isNotEmpty
                              ? order.deliveryMethod
                              : '---',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.textSecondaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    HeightSpace(12),
                    Divider(height: 1.h, color: AppColors.borderColor),
                    HeightSpace(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          context.l10n.orderTotal,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.textSecondaryColor,
                          ),
                        ),
                        Text(
                          '${order.totalPrice.toStringAsFixed(2)} ${context.l10n.egp}',
                          style: AppStyles.bodyLarge.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      color: AppColors.surfaceVariantColor,
      child: Icon(
        Icons.inventory_2_outlined,
        size: 32.sp,
        color: AppColors.textMutedColor,
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

extension on RentalOrderEntity {
  int get rentalDays {
    final days = endDate.difference(startDate).inDays;
    return days > 0 ? days : 1;
  }
}
