import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Location selection widget for booking
class BookingLocationSectionWidget extends StatelessWidget {
  final String pickupLocation;
  final String dropoffLocation;
  final DateTime pickupDate;
  final DateTime dropoffDate;
  final VoidCallback onLocationTap;

  const BookingLocationSectionWidget({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.pickupDate,
    required this.dropoffDate,
    required this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup Section
          _LocationTypeHeader(
            type: 'طريقة الاستلام',
            icon: Icons.location_on_outlined,
          ),
          verticalSpacing(8),
          GestureDetector(
            onTap: onLocationTap,
            child: _LocationTile(
              label: 'استلام من الموقع',
              value: pickupLocation,
              isClickable: true,
            ),
          ),
          verticalSpacing(16),
          // Pickup Date
          _LocationTypeHeader(
            type: 'يوم الاستلام',
            icon: Icons.calendar_today_outlined,
          ),
          verticalSpacing(8),
          _LocationTile(
            label: 'تاريخ اليوم',
            value: _formatDate(pickupDate),
            isClickable: false,
          ),
          verticalSpacing(16),
          // Dropoff Section
          _LocationTypeHeader(
            type: 'نوع الاستلام',
            icon: Icons.location_on_outlined,
          ),
          verticalSpacing(8),
          _LocationTile(
            label: 'استلام من الموقع',
            value: dropoffLocation,
            isClickable: false,
          ),
          verticalSpacing(16),
          // Dropoff Date
          _LocationTypeHeader(
            type: 'نوع الإرجاع',
            icon: Icons.calendar_today_outlined,
          ),
          verticalSpacing(8),
          _LocationTile(
            label: 'تاريخ اليوم',
            value: _formatDate(dropoffDate),
            isClickable: false,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _LocationTypeHeader extends StatelessWidget {
  final String type;
  final IconData icon;

  const _LocationTypeHeader({required this.type, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryColor, size: 16.w),
        horizontalSpacing(8),
        Text(
          type,
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _LocationTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isClickable;

  const _LocationTile({
    required this.label,
    required this.value,
    required this.isClickable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isClickable ? AppColors.primaryColor : AppColors.borderColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.textMutedColor,
                ),
              ),
              verticalSpacing(4),
              Text(
                value,
                style: AppStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          if (isClickable)
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primaryColor,
              size: 14.w,
            ),
        ],
      ),
    );
  }
}
