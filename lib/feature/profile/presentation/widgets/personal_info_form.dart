import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  static const List<String> _sexOptions = ['ذكر', 'أنثى'];

  static const Color _profilePrimaryColor = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                title: 'الاسم بالكامل',
                hintText: 'الاسم بالكامل',
                controller: fullNameController,
                validator: (value) {
                  final text = value ?? '';
                  if (text.trim().isEmpty) {
                    return 'الاسم بالكامل مطلوب';
                  }
                  if (!ValidationUtils.isValidFullName(text)) {
                    return 'يجب أن يكون الاسم 3 أحرف على الأقل';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomTextField(
                title: 'رقم الهاتف',
                hintText: 'رقم الهاتف',
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (value) {
                  final text = value ?? '';
                  if (text.trim().isEmpty) {
                    return 'رقم الهاتف مطلوب';
                  }
                  if (!ValidationUtils.isValidPhoneNumber(text)) {
                    return 'رقم الهاتف يجب أن يكون أرقام فقط وبحد أدنى 11 رقم';
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
            'الجنس',
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          initialValue: _sexOptions.contains(sex) ? sex : null,
          items: _sexOptions
              .map(
                (value) =>
                    DropdownMenuItem<String>(value: value, child: Text(value)),
              )
              .toList(),
          onChanged: onSexChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الجنس مطلوب';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'الجنس',
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
              borderSide: BorderSide(color: _profilePrimaryColor, width: 1),
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
