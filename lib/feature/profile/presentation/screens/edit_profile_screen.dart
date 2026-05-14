import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

/// Edit profile screen for updating user information
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController(
    text: 'Julian',
  );
  final TextEditingController _lastNameController = TextEditingController(
    text: 'Avery',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'julian.avery@poetry.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+1(555)012-3456',
  );
  final TextEditingController _nationalIdController = TextEditingController(
    text: '594938322220309',
  );
  final TextEditingController _countryController = TextEditingController(
    text: 'Egypt',
  );
  final TextEditingController _governorateController = TextEditingController(
    text: 'Cairo',
  );
  final TextEditingController _cityController = TextEditingController(
    text: 'New Cairo',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _nationalIdController.dispose();
    _countryController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(context.l10n.editProfile, style: AppStyles.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            // Profile Avatar Section
            _ProfileAvatarSection(),
            verticalSpacing(24),

            // Personal Info Section
            Text(
              'تعديل البيانات',
              style: AppStyles.titleMedium,
              textAlign: TextAlign.right,
            ),
            verticalSpacing(16),

            // Name Fields
            Row(
              children: [
                Expanded(
                  child: _TextFieldWithLabel(
                    label: 'الاسم الأول',
                    controller: _firstNameController,
                  ),
                ),
                horizontalSpacing(12),
                Expanded(
                  child: _TextFieldWithLabel(
                    label: 'اسم العائلة',
                    controller: _lastNameController,
                  ),
                ),
              ],
            ),
            verticalSpacing(16),

            // Email Field
            _TextFieldWithLabel(
              label: 'البريد الإلكتروني',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            verticalSpacing(16),

            // Phone Field
            _TextFieldWithLabel(
              label: 'رقم الهاتف',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            verticalSpacing(16),

            // National ID Field
            _TextFieldWithLabel(
              label: 'الرقم القومي',
              controller: _nationalIdController,
              keyboardType: TextInputType.number,
            ),
            verticalSpacing(24),

            // Address Section
            Text(
              'العنوان',
              style: AppStyles.titleMedium,
              textAlign: TextAlign.right,
            ),
            verticalSpacing(16),

            // Country Field
            _TextFieldWithLabel(
              label: 'الدولة',
              controller: _countryController,
              isReadOnly: true,
            ),
            verticalSpacing(16),

            // Governorate Field
            _TextFieldWithLabel(
              label: 'المحافظة',
              controller: _governorateController,
              isReadOnly: true,
            ),
            verticalSpacing(16),

            // City Field
            _TextFieldWithLabel(label: 'المدينة', controller: _cityController),
            verticalSpacing(32),

            // Action Buttons
            PrimaryButtonWidget(
              buttonText: 'حفظ التغييرات',
              onPress: () {
                // Save changes
                Navigator.pop(context);
              },
            ),
            verticalSpacing(12),
            PrimaryButtonWidget(
              buttonText: 'تغيير الصورة الشخصية',
              buttonColor: AppColors.primaryDarkColor,
              onPress: () {
                // Change profile picture
              },
            ),
            verticalSpacing(16),
          ],
        ),
      ),
    );
  }
}

class _ProfileAvatarSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          // Profile Avatar
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor, width: 3),
            ),
            child: ClipOval(
              child: Image.network(
                'https://via.placeholder.com/100x100?text=Profile',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person),
              ),
            ),
          ),
          verticalSpacing(12),
          Text('Julian Avery', style: AppStyles.titleMedium),
          verticalSpacing(4),
          Text(
            'Member since 2023',
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryColor,
            ),
          ),
          verticalSpacing(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariantColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Icon(
              Icons.camera_alt_outlined,
              color: AppColors.primaryColor,
              size: 18.w,
            ),
          ),
        ],
      ),
    );
  }
}

class _TextFieldWithLabel extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isReadOnly;

  const _TextFieldWithLabel({
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        verticalSpacing(8),
        CustomTextField(
          controller: controller,
          hintText: label,
          keyboardType: keyboardType,
          enabled: !isReadOnly,
        ),
      ],
    );
  }
}
