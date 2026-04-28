import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';

class TermsWidget extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;

  const TermsWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Checkbox (RTL aware)
        Checkbox(
          value: value,
          activeColor: AppColors.primaryColor,
          side: BorderSide(width: 1.sp, color: Colors.grey[400]!),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          onChanged: onChanged,
        ),

        // Terms and Privacy Text
        Expanded(
          child: Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[700],
                height: 1.4,
              ),
              children: [
                TextSpan(text: context.l10n.iAgreeToThe),
                TextSpan(
                  text: context.l10n.termsOfServiceLink,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // navigate to terms
                    },
                ),
                TextSpan(text: context.l10n.and),
                TextSpan(
                  text: context.l10n.privacyPolicyLink,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // navigate to privacy
                    },
                ),
                TextSpan(text: context.l10n.period),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
