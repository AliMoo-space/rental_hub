import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';

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
          side: const BorderSide(width: 1, color: AppColors.borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          onChanged: onChanged,
        ),

        // Terms and Privacy Text
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.textSecondaryColor,
              ),
              children: [
                TextSpan(text: context.l10n.iAgreeToThe),
                TextSpan(
                  text: context.l10n.termsOfServiceLink,
                  style: AppStyles.linkText,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // navigate to terms
                    },
                ),
                TextSpan(text: context.l10n.and),
                TextSpan(
                  text: context.l10n.privacyPolicyLink,
                  style: AppStyles.linkText,
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
