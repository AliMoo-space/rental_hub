import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';

class PersonalInfoForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController phoneNumberController;
  final String sex;
  final ValueChanged<String?> onSexChanged;

  const PersonalInfoForm({
    super.key,
    required this.fullNameController,
    required this.phoneNumberController,
    required this.sex,
    required this.onSexChanged,
  });

  static const List<String> _male = ['ذكر', 'Male'];
  static const List<String> _female = ['أنثى', 'Female'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                title: context.l10n.fullName,
                hintText: context.l10n.fullNameHint,
                controller: fullNameController,
                validator: (value) {
                  final text = value ?? '';
                  if (text.trim().isEmpty) {
                    return context.l10n.fullNameRequired;
                  }
                  if (!ValidationUtils.isValidFullName(text)) {
                    return context.l10n.fullNameMinLength;
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomTextField(
                title: context.l10n.phoneNumberLabel,
                hintText: context.l10n.phoneNumberLabel,
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final text = value ?? '';
                  if (text.trim().isEmpty) {
                    return context.l10n.phoneNumberRequired;
                  }
                  if (!ValidationUtils.isValidPhoneNumber(text)) {
                    return context.l10n.phoneNumberInvalid;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            context.l10n.genderLabel,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: sex,
          items: [
            DropdownMenuItem<String>(
              value: _male.contains(sex) ? sex : 'ذكر',
              child: Text(context.l10n.male),
            ),
            DropdownMenuItem<String>(
              value: _female.contains(sex) ? sex : 'أنثى',
              child: Text(context.l10n.female),
            ),
          ],
          onChanged: onSexChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return context.l10n.genderRequired;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: context.l10n.genderLabel,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: AppColors.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: AppColors.errorColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.r),
              borderSide: const BorderSide(color: AppColors.errorColor),
            ),
            filled: true,
            fillColor: AppColors.surfaceColor,
          ),
        ),
      ],
    );
  }
}
