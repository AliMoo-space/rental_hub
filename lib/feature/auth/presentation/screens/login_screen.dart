import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/social_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  @override
  void initState() {
    super.initState();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeightSpace(48),
                Text(
                  'Rental Hub',
                  style: AppStyles.primaryHeadLinesStyle.copyWith(
                    color: AppColors.primaryColor,
                    fontSize: 48.sp,
                  ),
                ),
                Text(
                  'Welcome back. Your next premiumstay is just a few taps away.',
                  style: AppStyles.subtitlesStyles,
                ),
                HeightSpace(48),
                CustomTextField(
                  title: 'Email Address',
                  hintText: 'hello@gmail.com',
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return 'Enter Your Email';
                    }
                    return null;
                  },
                  controller: email,
                  spacing: 16,
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: 14.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Password', style: AppStyles.black10BoldStyle),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: AppStyles.black10BoldStyle.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                HeightSpace(6),
                CustomTextField(
                  hintText: '********',
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return 'Enter Your Password';
                    }
                    if (p.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  isPassword: true,
                  controller: password,
                  spacing: 16,
                ),
                PrimrayButtonWidget(
                  buttonText: 'Login to Hub',
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      log('object');
                    }
                  },
                ),
                HeightSpace(32),
                SocialLoginWidget(text: 'CONNECT WITH'),
                HeightSpace(32),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: Text(
          'Terms of Service',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
