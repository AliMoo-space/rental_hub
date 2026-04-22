import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

class CustomTextField extends StatefulWidget {
  final double? spacing;
  final String? title;
  final String? hintText;
  final Widget? suffixIcon;
  final double? width;
  final bool? isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.width,
    this.isPassword,
    this.controller,
    this.validator,
    this.onChanged,
    this.title,
    this.spacing,
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
    return SizedBox(
      width: widget.width ?? 331.w,
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.spacing ?? 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.title != null)
              Text(widget.title!, style: AppStyles.black10BoldStyle),
            if (widget.title != null) HeightSpace(6),
            TextFormField(
              focusNode: _focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              onChanged: widget.onChanged,
              controller: widget.controller,
              validator: widget.validator,
              autofocus: false,
              obscureText: widget.isPassword == true ? _obscureText : false,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: widget.hintText ?? "",
                hintStyle: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xff8391A1),
                  fontWeight: FontWeight.w200,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18.w,
                  vertical: 18.h,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: Color(0xffE8ECF4), width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(
                    color: AppColors.primaryColor,
                    width: 1,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: const BorderSide(color: Colors.red, width: 1),
                ),
                filled: true,
                fillColor: const Color(0xffF7F8F9),
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
                          color: AppColors.secondaryColor,
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
