import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/domain/entities/login_params.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_state.dart';
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

  void _onLoginPressed() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    context.read<LoginCubit>().login(
      LoginParams(email: email.text.trim(), password: password.text.trim()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          showMsg(state.message, context, isError: true);
        }
        if (state is LoginSuccess) {
          showMsg(context.l10n.loginSuccessful, context);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
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
                        Text(
                          context.l10n.rentalHub,
                          style: AppStyles.displayLarge.copyWith(
                            color: AppColors.primaryColor,
                            fontSize: 48.sp,
                          ),
                        ),
                        HeightSpace(12.h),
                        Text(
                          context.l10n.welcomeBackLogin,
                          style: AppStyles.bodyMedium,
                        ),
                        HeightSpace(48.h),

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

                        // Password Label and Forgot Password
                        HeightSpace(12.h),
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            end: isRtl ? 0 : 14.w,
                            start: isRtl ? 14.w : 0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  context.l10n.password,
                                  style: AppStyles.inputLabel,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.pushNamed(
                                    AppRoutes.forgotPasswordScreen,
                                  );
                                },
                                child: Text(
                                  context.l10n.forgotPassword,
                                  style: AppStyles.bodySmall.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        HeightSpace(4.h),

                        // Password Field
                        CustomTextField(
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

                        // Login Button
                        HeightSpace(24.h),
                        PrimaryButtonWidget(
                          buttonText: context.l10n.loginToHub,
                          isLoading: isLoading,
                          onPress: () {
                            context.go(AppRoutes.mainScreen);
                            // _onLoginPressed,
                          },
                        ),

                        // Social Login Section
                        HeightSpace(32.h),
                        SocialLoginWidget(
                          text: context.l10n.connectWith,
                          onGooglePressed: () {
                            log('Google sign-in tapped');
                            showMsg(
                              context.l10n.googleSignInNotImplemented,
                              context,
                              isError: true,
                            );
                          },
                        ),
                        HeightSpace(32.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: InkWell(
              onTap: () {
                showMsg(context.l10n.termsOfServicePageComingSoon, context);
              },
              child: Text(
                context.l10n.termsOfService,
                textAlign: TextAlign.center,
                style: AppStyles.bodySmall.copyWith(
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
