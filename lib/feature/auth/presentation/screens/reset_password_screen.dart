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
import 'package:rental_hub/feature/auth/presentation/cubit/reset_password_cubit.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _onResetPressed() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<ResetPasswordCubit>().resetPassword(
      password: passwordController.text.trim(),
      confirmPassword: confirmPasswordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordError) {
          showMsg(state.message, context, isError: true);
        }

        if (state is ResetPasswordSuccess) {
          context.pushReplacementNamed(AppRoutes.authSuccessScreen);
        }
      },
      builder: (context, state) {
        final isLoading = state is ResetPasswordLoading;

        return Scaffold(
          appBar: AppBar(),
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
                        HeightSpace(12.h),

                        // Header Section
                        Text.rich(
                          TextSpan(
                            style: AppStyles.primaryHeadLinesStyle.copyWith(
                              fontSize: 36.sp,
                              color: Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: isRtl
                                    ? '${context.l10n.resetPassword} '
                                    : 'Reset ',
                              ),
                              TextSpan(
                                text: isRtl ? '' : context.l10n.password,
                                style: TextStyle(color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ),
                        HeightSpace(12.h),
                        Text(
                          context.l10n.resetPasswordSubtitle,
                          style: AppStyles.subtitlesStyles.copyWith(
                            fontSize: 14.sp,
                          ),
                        ),
                        HeightSpace(48.h),

                        // New Password Field
                        CustomTextField(
                          title: context.l10n.newPassword,
                          hintText: '••••••••',
                          isPassword: true,
                          controller: passwordController,
                          spacing: 16.h,
                          validator: (value) {
                            final input = value?.trim() ?? '';
                            if (input.isEmpty) {
                              return context.l10n.enterYourPassword;
                            }
                            if (input.length < 6) {
                              return context.l10n.passwordMinLength;
                            }
                            return null;
                          },
                        ),

                        // Confirm Password Field
                        CustomTextField(
                          title: context.l10n.confirmPassword,
                          hintText: '••••••••',
                          isPassword: true,
                          controller: confirmPasswordController,
                          spacing: 16.h,
                          validator: (value) {
                            final input = value?.trim() ?? '';
                            if (input.isEmpty) {
                              return context.l10n.confirmPasswordMessage;
                            }
                            if (input != passwordController.text.trim()) {
                              return context.l10n.passwordsDoNotMatch;
                            }
                            return null;
                          },
                        ),

                        // Update Password Button
                        HeightSpace(24.h),
                        PrimaryButtonWidget(
                          buttonText: context.l10n.updatePassword,
                          isLoading: isLoading,
                          onPress: () {
                            context.go(AppRoutes.authSuccessScreen);

                            // _onResetPressed,
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
