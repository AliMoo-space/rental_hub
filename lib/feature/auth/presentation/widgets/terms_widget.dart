import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
        

        // Terms and Privacy Text (centered, single-line)
        Expanded(
          child: Text.rich(
            TextSpan(
              style: AppStyles.labelSmall.copyWith(
                color: AppColors.textSecondaryColor,
              ),
              children: [
                TextSpan(text: context.l10n.termsAgreementPrefix),
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
                TextSpan(text: context.l10n.termsAgreementSuffix),
              ],
            ),
            textAlign: TextAlign.center,
        
          ),
        ),
      ],
    );
  }
}
