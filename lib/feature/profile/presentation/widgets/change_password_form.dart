import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static const Color _profilePrimaryColor = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextField(
            title: 'كلمة المرور الحالية',
            hintText: 'كلمة المرور الحالية',
            controller: currentPasswordController,
            isPassword: true,
            validator: (value) {
              if ((value ?? '').trim().isEmpty) {
                return 'كلمة المرور الحالية مطلوبة';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            title: 'كلمة المرور الجديدة',
            hintText: 'كلمة المرور الجديدة',
            controller: newPasswordController,
            isPassword: true,
            validator: (value) {
              final text = value ?? '';
              if (text.trim().isEmpty) {
                return 'كلمة المرور الجديدة مطلوبة';
              }
              if (!ValidationUtils.isValidPassword(text)) {
                return '8 أحرف على الأقل مع حرف كبير ورقم ورمز خاص';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          CustomTextField(
            title: 'تأكيد كلمة المرور',
            hintText: 'تأكيد كلمة المرور',
            controller: confirmNewPasswordController,
            isPassword: true,
            validator: (value) {
              final text = value ?? '';
              if (text.trim().isEmpty) {
                return 'تأكيد كلمة المرور مطلوب';
              }
              if (text != newPasswordController.text) {
                return 'كلمتا المرور غير متطابقتين';
              }
              return null;
            },
          ),
          SizedBox(height: 24.h),
          PrimaryButtonWidget(
            buttonText: 'تغيير كلمة المرور',
            onPress: onSubmit,
            buttonColor: _profilePrimaryColor,
            isLoading: isLoading,
            width: double.infinity,
            height: 56.h,
          ),
        ],
      ),
    );
  }
}
