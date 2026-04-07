import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeightSpace(12),
                    Text.rich(
                      TextSpan(
                        style: AppStyles.primaryHeadLinesStyle.copyWith(
                          fontSize: 36.sp,
                          color: Colors.black,
                        ),
                        children: [
                          const TextSpan(text: 'Reset '),
                          TextSpan(
                            text: 'Password',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Create a new password for your Rental Hub account.',
                      style: AppStyles.subtitlesStyles,
                    ),
                    HeightSpace(48),
                    CustomTextField(
                      title: 'New Password',
                      hintText: '********',
                      isPassword: true,
                      controller: passwordController,
                      spacing: 16,
                      validator: (value) {
                        final input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return 'Enter Your Password';
                        }
                        if (input.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      title: 'Confirm Password',
                      hintText: '********',
                      isPassword: true,
                      controller: confirmPasswordController,
                      spacing: 16,
                      validator: (value) {
                        final input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return 'Confirm your password';
                        }
                        if (input != passwordController.text.trim()) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    HeightSpace(24),
                    PrimaryButtonWidget(
                      buttonText: 'Update Password',
                      isLoading: isLoading,
                      onPress: _onResetPressed,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
