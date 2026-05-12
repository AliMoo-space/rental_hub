import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryOutlineButtonWidget extends StatelessWidget {
  const PrimaryOutlineButtonWidget({
    super.key,
    required this.onPressed,
    this.text,
    this.textColor,
    this.borderColor,
    this.borderRadius,
    this.width,
    this.height,
    this.fontSize,
  });
  final void Function() onPressed;
  final String? text;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final double? fontSize;
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDarkMode ? const Color(0xFF111827) : Colors.white,

        side: BorderSide(color: borderColor ?? Colors.redAccent, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
        ),
        fixedSize: Size(width ?? 267.w, height ?? 45.h),
      ),
      child: Text(
        text ?? '',
        style: TextStyle(
          color: textColor ?? Colors.redAccent,
          fontSize: fontSize ?? 15.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
