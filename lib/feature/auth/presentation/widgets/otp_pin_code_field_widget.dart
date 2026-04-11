import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class OtpPinCodeFieldWidget extends StatelessWidget {
  const OtpPinCodeFieldWidget({
    super.key,
    required this.controller,
    required this.onChanged,
    this.length = 6,
  });

  final PinInputController controller;
  final ValueChanged<String> onChanged;
  final int length;

  @override
  Widget build(BuildContext context) {
    return MaterialPinField(
      pinController: controller,
      length: length,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      enablePaste: true,
      theme: MaterialPinTheme(
        shape: MaterialPinShape.outlined,
        cellSize: Size(48.w, 56.h),
        borderRadius: BorderRadius.circular(16.r),
        spacing: 10.w,
        fillColor: const Color(0xffF7F8F9),
        focusedFillColor: const Color(0xffF7F8F9),
        filledFillColor: const Color(0xffF7F8F9),
        borderColor: const Color(0xffE8ECF4),
        focusedBorderColor: AppColors.primaryColor,
        filledBorderColor: const Color(0xffE8ECF4),
        textStyle: AppStyles.black18BoldStyle,
        cursorColor: AppColors.primaryColor,
        entryAnimation: MaterialPinAnimation.fade,
      ),
      onChanged: onChanged,
    );
  }
}
