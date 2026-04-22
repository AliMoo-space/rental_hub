import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                        const TextSpan(text: 'Verify '),
                        TextSpan(
                          text: 'Code',
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Enter the 6-digit code sent to ${widget.email}',
                    style: AppStyles.subtitlesStyles,
                  ),
                  HeightSpace(48),
                  OtpPinCodeFieldWidget(
                    controller: _pinController,
                    length: _codeLength,
                    onChanged: (value) {
                      context.read<OtpCubit>().updateCode(value);
                    },
                  ),
                  HeightSpace(24),

                  PrimaryButtonWidget(
                    buttonText: 'Verify Code',
                    isLoading: isLoading,
                    onPress: () {
                      context.read<OtpCubit>().verifyCode();
                    },
                  ),
                  HeightSpace(24),
                  Center(
                    child: TextButton(
                      onPressed: state.canResend
                          ? () {
                              context.read<OtpCubit>().resendCode();
                            }
                          : null,
                      child: Text(
                        state.canResend
                            ? 'Resend Code'
                            : 'Resend in ${state.secondsRemaining}s',
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
        );
      },
    );
  }
}
