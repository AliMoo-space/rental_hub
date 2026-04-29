import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
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

  void _onSignUpPressed(BuildContext context) {
    final isFormValid = formKey.currentState!.validate();

    if (!isChecked) {
      showMsg(context.l10n.termsOfService, context, isError: true);
      return;
    }

    if (isFormValid && isChecked) {
      // signup logic
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Form(
              key: formKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 600.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(48.h),

                    // Header Section
                    Text.rich(
                      TextSpan(
                        style: AppStyles.displayLarge,
                        children: [
                          TextSpan(
                            text: isRtl ? '${context.l10n.rentalHub} ' : '',
                          ),
                          TextSpan(text: isRtl ? 'انضم إلى' : 'Join '),
                          TextSpan(
                            text: isRtl ? '' : context.l10n.rentalHub,
                            style: AppStyles.linkText.copyWith(
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    HeightSpace(12.h),
                    Text(
                      context.l10n.createAccountSubtitle,
                      style: AppStyles.bodyMedium,
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

                    // Password Field
                    HeightSpace(4.h),
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

                    // Terms and Privacy Widget
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
        ),
      ),
    );
  }
}
