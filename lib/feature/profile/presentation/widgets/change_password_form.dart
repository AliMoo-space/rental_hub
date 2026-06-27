import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';

class ChangePasswordForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmNewPasswordController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const ChangePasswordForm({
    super.key,
    required this.formKey,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmNewPasswordController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            title: context.l10n.currentPassword,
            hintText: context.l10n.currentPassword,
            controller: currentPasswordController,
            isPassword: true,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return context.l10n.currentPasswordRequired;
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            title: context.l10n.newPassword,
            hintText: context.l10n.newPassword,
            controller: newPasswordController,
            isPassword: true,
            validator: (value) {
              final text = value ?? '';
              if (text.trim().isEmpty) {
                return context.l10n.newPasswordRequired;
              }
              if (!ValidationUtils.isValidPassword(text)) {
                return context.l10n.passwordMinRequirements;
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            title: context.l10n.confirmNewPassword,
            hintText: context.l10n.confirmNewPassword,
            controller: confirmNewPasswordController,
            isPassword: true,
            validator: (value) {
              final text = value ?? '';
              if (text.trim().isEmpty) {
                return context.l10n.confirmNewPasswordRequired;
              }
              if (text != newPasswordController.text) {
                return context.l10n.passwordsNotMatch;
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          PrimaryButtonWidget(
            buttonText: context.l10n.changePassword,
            onPress: onSubmit,
            buttonColor: AppColors.primaryColor,
            isLoading: isLoading,
            width: double.infinity,
            height: 56.h,
          ),
        ],
      ),
    );
  }
}
