import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/otp_pin_code_field_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;
  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _codeLength = 6;

  late PinInputController _pinController;

  @override
  void initState() {
    super.initState();
    _pinController = PinInputController();
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _syncPinController(List<String> digits) {
    final value = digits.join();
    if (_pinController.text != value) {
      _pinController.setText(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;

    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        _syncPinController(state.digits);
        if (state is OtpError) {
          showMsg(state.message, context, isError: true);
        }

        if (state is OtpSuccess) {
          showMsg(state.message, context);
          context.pushNamed(AppRoutes.resetPasswordScreen, extra: widget.email);
        }

        if (state is OtpCodeResent) {
          showMsg(state.message, context);
        }
      },
      builder: (context, state) {
        final isLoading = state is OtpLoading;

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
                                  ? '${context.l10n.verifyCode} '
                                  : 'Verify ',
                            ),
                            TextSpan(
                              text: isRtl ? '' : context.l10n.next,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      HeightSpace(12.h),
                      Text(
                        context.l10n.verifyCodeSubtitle(widget.email),
                        style: AppStyles.subtitlesStyles.copyWith(
                          fontSize: 14.sp,
                        ),
                      ),
                      HeightSpace(48.h),

                      // OTP Input Field
                      OtpPinCodeFieldWidget(
                        controller: _pinController,
                        length: _codeLength,
                        onChanged: (value) {
                          context.read<OtpCubit>().updateCode(value);
                        },
                      ),
                      HeightSpace(24.h),

                      // Verify Code Button
                      PrimaryButtonWidget(
                        buttonText: context.l10n.verifyCode,
                        isLoading: isLoading,
                        onPress: () {
                          context.go(
                            AppRoutes.resetPasswordScreen,
                            extra: widget.email,
                          );
                          // context.read<OtpCubit>().verifyCode();
                        },
                      ),

                      // Resend Code Button
                      HeightSpace(24.h),
                      Center(
                        child: TextButton(
                          onPressed: state.canResend
                              ? () {
                                  context.read<OtpCubit>().resendCode();
                                }
                              : null,
                          child: Text(
                            state.canResend
                                ? context.l10n.resendCode
                                : '${context.l10n.resendCode} ${state.secondsRemaining}s',
                            style: AppStyles.black10BoldStyle.copyWith(
                              color: state.canResend
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
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
