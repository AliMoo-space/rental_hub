import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

/// Booking progress stepper widget showing current step (1/2/3)
class BookingStepperWidget extends StatelessWidget {
  final int currentStep; // 1, 2, or 3
  final List<String> stepLabels;

  const BookingStepperWidget({
    super.key,
    required this.currentStep,
    this.stepLabels = const ['الدفع والتأكيد', 'معاينة العقد', 'تفاصيل الحجز'],
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            stepLabels.length,
            (index) => Expanded(
              child: _StepIndicator(
                stepNumber: index + 1,
                isCompleted: index < currentStep - 1,
                isActive: index == currentStep - 1,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            stepLabels.length,
            (index) => Expanded(
              child: Text(
                stepLabels[index],
                textAlign: TextAlign.center,
                style: AppStyles.bodySmall.copyWith(
                  color: index <= currentStep - 1
                      ? AppColors.primaryColor
                      : AppColors.textMutedColor,
                  fontSize: 10.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  final int stepNumber;
  final bool isCompleted;
  final bool isActive;

  const _StepIndicator({
    required this.stepNumber,
    required this.isCompleted,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted || isActive
            ? AppColors.primaryColor
            : AppColors.surfaceVariantColor,
      ),
      width: 40.w,
      height: 40.w,
      child: Center(
        child: isCompleted
            ? Icon(Icons.check, color: Colors.white, size: 20.w)
            : Text(
                stepNumber.toString(),
                style: AppStyles.titleMedium.copyWith(
                  color: isActive ? Colors.white : AppColors.textMutedColor,
                  fontSize: 16.sp,
                ),
              ),
      ),
    );
  }
}
