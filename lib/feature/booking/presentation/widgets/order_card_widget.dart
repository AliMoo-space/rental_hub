import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_status_badge.dart';

class OrderCardWidget extends StatelessWidget {
  final RentalOrderEntity order;
  final bool showRenterName;
  final VoidCallback? onTap;

  const OrderCardWidget({
    super.key,
    required this.order,
    this.showRenterName = false,
    this.onTap,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.borderColor),
            boxShadow: [AppShadows.softCard],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImage(),
              WidthSpace(12),
              Expanded(child: _buildContent(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        width: 72.w,
        height: 72.w,
        color: AppColors.surfaceColor,
        child: order.productImage.isNotEmpty
            ? Image.network(
                order.productImage,
                width: 72.w,
                height: 72.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imagePlaceholder(),
              )
            : _imagePlaceholder(),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.surfaceVariantColor,
      child: Icon(
        Icons.inventory_2_outlined,
        size: 28.sp,
        color: AppColors.textMutedColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final days = order.endDate
        .difference(order.startDate)
        .inDays
        .clamp(1, 9999);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                order.productName.isNotEmpty
                    ? order.productName
                    : '${context.l10n.productNumber}${order.productId}',
                style: AppStyles.bodyLarge.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            OrderStatusBadge(status: order.status),
          ],
        ),
        HeightSpace(10),
        if (showRenterName) ...[
          _infoRow(
            Icons.person_outline_rounded,
            '${context.l10n.renterLabel}: ${order.renterName}',
          ),
          HeightSpace(6),
        ],
        Row(
          children: [
            Icon(
              Icons.calendar_today_rounded,
              size: 14.sp,
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
            WidthSpace(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.primarySoftColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '$days ${context.l10n.dayLabel}',
                style: AppStyles.labelSmall.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        HeightSpace(6),
        _infoRow(
          Icons.local_shipping_outlined,
          '${context.l10n.deliveryMethodLabel}: ${order.deliveryMethod.isNotEmpty ? order.deliveryMethod : '---'}',
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
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.textMutedColor),
        SizedBox(width: 6.w),
        Flexible(
          child: Text(
            text,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              fontSize: 12.sp,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
