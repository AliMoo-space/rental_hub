import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
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
                ? context.l10n.verificationCodeSent
                : state.entity.email,
            context,
          );
          context.goNamed(AppRoutes.otpVerificationScreen, extra: state.email);
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgotPasswordLoading;
        final isRtl = Directionality.of(context) == TextDirection.rtl;

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
                            style: AppStyles.displayLarge,
                            children: [
                              TextSpan(
                                text: isRtl
                                    ? '${context.l10n.forgotPasswordTitle} '
                                    : 'Forgot ',
                              ),
                              TextSpan(
                                text: isRtl ? '' : context.l10n.password,
                                style: AppStyles.linkText.copyWith(
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
                          ),
                        ),
                        HeightSpace(12.h),
                        Text(
                          context.l10n.forgotPasswordSubtitle,
                          style: AppStyles.bodyMedium,
                        ),
                        HeightSpace(48.h),

                        // Email Field
                        CustomTextField(
                          title: context.l10n.emailAddress,
                          hintText: context.l10n.emailHint,
                          controller: emailController,
                          spacing: 16.h,
                          validator: (value) {
                            final input = value?.trim() ?? '';
                            if (input.isEmpty) {
                              return context.l10n.enterYourEmail;
                            }
                            final emailRegex = RegExp(
                              r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                            );
                            if (!emailRegex.hasMatch(input)) {
                              return context.l10n.validEmail;
                            }
                            return null;
                          },
                        ),

                        // Send Code Button
                        HeightSpace(24.h),
                        PrimaryButtonWidget(
                          buttonText: context.l10n.sendVerificationCode,
                          isLoading: isLoading,
                          onPress: () {
                            context.go(AppRoutes.otpVerificationScreen);
                          },
                          // _onSendPressed,
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
