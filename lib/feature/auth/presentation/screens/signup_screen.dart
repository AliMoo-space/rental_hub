import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/social_login_widget.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/terms_widget.dart';

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

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
  }

  @override
  void dispose() {
    name.dispose();
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
                Text.rich(
                  TextSpan(
                    style: AppStyles.primaryHeadLinesStyle.copyWith(
                      fontSize: 36.sp,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(text: 'Join '),
                      TextSpan(
                        text: 'Rental Hub',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
                Text(
                  'Create an account to start exploring premium properties today.',
                  style: AppStyles.subtitlesStyles,
                ),
                HeightSpace(48),
                CustomTextField(
                  title: 'Full Name',
                  hintText: 'Ali Mohamed',
                  validator: (p) {
                    if (p == null || p.isEmpty) {
                      return 'Enter Your Full Name';
                    }
                    return null;
                  },
                  controller: name,
                  spacing: 16,
                ),
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
                HeightSpace(6),
                CustomTextField(
                  title: 'Password',
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
                TermsWidget(
                  value: isChecked,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                HeightSpace(40),

                PrimrayButtonWidget(
                  buttonText: 'Create Account',
                  onPress: () {
                    final isFormValid = formKey.currentState!.validate();

                    if (!isChecked) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('You must agree to Terms & Privacy'),
                        ),
                      );
                    }
                    if (isFormValid && isChecked) {
                      // signup logic
                    }
                  },
                ),
                HeightSpace(32),
                SocialLoginWidget(text: 'OR CONNECT WITH'),
                HeightSpace(32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
