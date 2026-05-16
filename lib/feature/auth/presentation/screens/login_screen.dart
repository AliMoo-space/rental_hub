import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
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
import 'package:rental_hub/feature/auth/presentation/widgets/terms_widget.dart';

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
    email = TextEditingController(text: 'mhmdfouad093@gmail.com');
    password = TextEditingController(text: 'Fouad@2463187');
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
          context.pushNamed(AppRoutes.mainScreen);
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.bottomStart,
                        child: SvgPicture.asset(AppAssets.logo2, width: 225.w),
                      ),
                      HeightSpace(10.h),
                      Text(
                        context.l10n.welcomeBackLogin,
                        style: AppStyles.bodyMedium,
                      ),
                      HeightSpace(32.h),
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
                        width: double.infinity,
                        spacing: 18.h,
                      ),
                      HeightSpace(4.h),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          end: 6.w,
                          start: 6.w,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                context.l10n.password,
                                style: AppStyles.labelSmall,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.forgotPasswordScreen,
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: Text(
                                  context.l10n.forgotPassword,
                                  style: AppStyles.bodySmall.copyWith(
                                    color: AppColors.primaryColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      HeightSpace(8.h),
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
                        width: double.infinity,
                        spacing: 20.h,
                      ),
                      HeightSpace(8.h),
                      Center(
                        child: PrimaryButtonWidget(
                          buttonText: context.l10n.loginToHub,
                          isLoading: isLoading,
                          onPress: _onLoginPressed,
                        ),
                      ),
                      HeightSpace(28.h),
                      SocialLoginWidget(
                        text: context.l10n.connectWith,
                        onFacebookPressed: () {
                          log('Facebook sign-in tapped');
                          showMsg(
                            context.l10n.facebookSignInNotImplemented,
                            context,
                            isError: true,
                          );
                        },
                        onGooglePressed: () {
                          log('Google sign-in tapped');
                          showMsg(
                            context.l10n.googleSignInNotImplemented,
                            context,
                            isError: true,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: 20.h),
            child: TermsWidget(value: false, onChanged: (value) {}),
          ),
        );
      },
    );
  }
}
