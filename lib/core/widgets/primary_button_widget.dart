import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String? buttonText;
  final TextStyle? style;
  final Color? buttonColor;
  final double? width;
  final double? height;
  final double? bordersRadius;
  final Color? textColor;
  final double? fontSize;
  final Widget? icon;
  final Widget? trailingIcon;
  final void Function()? onPress;
  final bool isLoading;
  final bool enabled;
  const PrimaryButtonWidget({
    super.key,
    this.buttonText,
    this.buttonColor,
    this.width,
    this.height,
    this.bordersRadius,
    this.fontSize,
    this.textColor,
    this.icon,
    this.trailingIcon,
    this.onPress,
    this.isLoading = false,
    this.enabled = true,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading || !enabled ? null : onPress ?? () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? AppColors.primaryColor,
        disabledBackgroundColor: AppColors.textMutedColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(bordersRadius ?? 24.r),
        ),
        fixedSize: Size(width ?? 331.w, height ?? 70.h),
      ),
      child: isLoading
          ? SizedBox(
              width: 30.sp,
              height: 30.sp,
              child: const CircularProgressIndicator(color: Colors.white),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                icon != null ? const WidthSpace(8) : const SizedBox.shrink(),
                Text(
                  buttonText ?? "",
                  style:
                      style ??
                      AppStyles.buttonLabel.copyWith(
                        color: textColor ?? AppColors.whiteColor,
                        fontSize: fontSize ?? 16.sp,
                      ),
                ),
                trailingIcon != null
                    ? const WidthSpace(8)
                    : const SizedBox.shrink(),
                trailingIcon != null ? trailingIcon! : const SizedBox.shrink(),
              ],
            ),
    );
  }
}
