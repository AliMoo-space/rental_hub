import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

class CustomTextField extends StatefulWidget {
  final double? spacing;
  final String? title;
  final String? hintText;
  final Widget? suffixIcon;
  final double? width;
  final bool? isPassword;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final TextInputType? keyboardType;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final void Function(String)? onFieldSubmitted;

  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.width,
    this.isPassword,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.onChanged,
    this.title,
    this.spacing,
    this.keyboardType,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _obscureText = true;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.spacing ?? 0),
        child: Column(
          children: [
            if (widget.title != null)
              Align(
                alignment: AlignmentDirectional.bottomStart,
                child: Text(widget.title!, style: AppStyles.labelSmall),
              ),
            if (widget.title != null) SizedBox(height: 6.h),
            TextFormField(
              focusNode: _focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              onChanged: widget.onChanged,
              controller: widget.controller,
              validator: widget.validator,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              autofocus: widget.autofocus,
              onFieldSubmitted: widget.onFieldSubmitted,
              obscureText: widget.isPassword == true ? _obscureText : false,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: widget.hintText ?? '',
                hintStyle: AppStyles.inputHint.copyWith(
                  color: isDarkMode
                      ? AppColors.textMutedColor
                      : AppColors.textSecondaryColor,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 18.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(
                    color: isDarkMode
                        ? const Color(0xFF334155)
                        : AppColors.borderColor,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: const BorderSide(
                    color: AppColors.errorColor,
                    width: 1,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: const BorderSide(
                    color: AppColors.errorColor,
                    width: 1,
                  ),
                ),
                filled: true,
                fillColor: isDarkMode
                    ? const Color(0xFF111827)
                    : AppColors.surfaceColor,
                suffixIcon: widget.isPassword == true
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDarkMode
                              ? AppColors.textMutedColor
                              : AppColors.textSecondaryColor,
                          size: 20.sp,
                        ),
                      )
                    : widget.suffixIcon,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
