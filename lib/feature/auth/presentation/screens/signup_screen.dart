import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/social_login_widget.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/terms_widget.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/upload_image_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final formKey = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  late TextEditingController nationalId;
  File? selectedImage;
  String? imageError;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
    nationalId = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    nationalId.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        imageError = null;
      });
    }
  }

  bool validateImage() {
    if (selectedImage == null) {
      setState(() {
        imageError = "Please upload image";
      });
      return false;
    }

    return true;
  }

  void _onSignUpPressed(BuildContext context) {
    final isFormValid = formKey.currentState!.validate();
    final isImageValid = validateImage();

    if (!isChecked) return;

    if (isFormValid && isImageValid && isChecked) {
      context.goNamed(AppRoutes.mainScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeightSpace(48.h),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: SvgPicture.asset(AppAssets.logo2, width: 225.w),
                ), // Header Section
                HeightSpace(12.h),
                Align(
                  alignment: AlignmentDirectional.bottomStart,

                  child: Text(
                    context.l10n.createAccountSubtitle,
                    style: AppStyles.bodyMedium,
                  ),
                ),
                HeightSpace(48.h),

                // Full Name Field
                CustomTextField(
                  title: context.l10n.fullName,
                  hintText: context.l10n.fullNameHint,
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return context.l10n.enterYourFullName;
                    }
                    return null;
                  },
                  controller: name,
                  spacing: 16.h,
                ),

                // Email Field
                CustomTextField(
                  title: context.l10n.emailAddress,
                  hintText: context.l10n.emailHint,
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return context.l10n.enterYourEmail;
                    }
                    return null;
                  },
                  controller: email,
                  spacing: 16.h,
                ),
                CustomTextField(
                  title: context.l10n.nationalId,
                  hintText: context.l10n.enterTheNationalNumber,
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return context.l10n.enterTheNationalNumber;
                    }
                    return null;
                  },
                  controller: nationalId,
                  spacing: 16.h,
                ),

                // Password Field
                CustomTextField(
                  title: context.l10n.password,
                  hintText: '••••••••',
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return context.l10n.enterYourPassword;
                    }
                    if (p.length < 6) {
                      return context.l10n.passwordMinLength;
                    }
                    return null;
                  },
                  isPassword: true,
                  controller: password,
                  spacing: 16.h,
                ),
                CustomTextField(
                  title: context.l10n.confirmPassword,
                  hintText: '••••••••',
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return context.l10n.enterYourPassword;
                    }
                    if (p != password.text) {
                      return context.l10n.passwordsDoNotMatch;
                    }
                    return null;
                  },
                  isPassword: true,
                  controller: confirmPassword,
                  spacing: 16.h,
                ),
                HeightSpace(6.h),
                Align(
                  alignment: AlignmentDirectional.bottomStart,
                  child: Text(
                    context.l10n.nationalId,
                    style: AppStyles.labelSmall,
                  ),
                ),
                HeightSpace(8.h),
                UploadImageWidget(
                  imageFile: selectedImage,
                  errorText: imageError,
                  onTap: pickImage,
                ), // Terms and Privacy Widget
                HeightSpace(20.h),
                TermsWidget(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),

                // Create Account Button
                HeightSpace(24.h),
                PrimaryButtonWidget(
                  buttonText: context.l10n.signup,
                  onPress: () {
                    // context.go(AppRoutes.mainScreen);
                    _onSignUpPressed(context);
                  },
                ),

                // Social Login Section
                HeightSpace(24.h),
                SocialLoginWidget(text: context.l10n.connectWith),
                HeightSpace(24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
