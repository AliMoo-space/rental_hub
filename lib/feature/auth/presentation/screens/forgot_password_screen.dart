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
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }

    context.read<ForgotPasswordCubit>().sendResetRequest(emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          showMsg(state.message, context, isError: true);
        }

        if (state is ForgotPasswordSuccess) {
          showMsg(
            state.entity.email.isEmpty
                ? 'Verification code sent successfully'
                : state.entity.email,
            context,
          );
          context.goNamed(AppRoutes.otpVerificationScreen, extra: state.email);
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;
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
                          const TextSpan(text: 'Forgot '),
                          TextSpan(
                            text: 'Password',
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Enter your email and we will send a verification code to reset your password.',
                      style: AppStyles.subtitlesStyles,
                    ),
                    HeightSpace(48),
                    CustomTextField(
                      title: 'Email Address',
                      hintText: 'hello@gmail.com',
                      controller: emailController,
                      spacing: 16,
                      validator: (value) {
                        final input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return 'Enter Your Email';
                        }
                        final emailRegex = RegExp(
                          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                        );
                        if (!emailRegex.hasMatch(input)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    HeightSpace(24),
                    PrimaryButtonWidget(
                      buttonText: 'Send Verification Code',
                      isLoading: isLoading,
                      onPress: _onSendPressed,
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
