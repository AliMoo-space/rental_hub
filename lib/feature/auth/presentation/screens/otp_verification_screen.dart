import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  static const int _codeLength = 6;

  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_codeLength, (_) => TextEditingController());
    _focusNodes = List.generate(_codeLength, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _updateControllersFromState(List<String> digits) {
    for (var i = 0; i < _codeLength; i++) {
      final nextValue = i < digits.length ? digits[i] : '';
      if (_controllers[i].text != nextValue) {
        _controllers[i].text = nextValue;
      }
    }
  }

  void _onDigitChanged(int index, String value) {
    final sanitized = value.isEmpty ? '' : value.characters.last;
    _controllers[index].text = sanitized;

    context.read<OtpCubit>().updateDigit(index, sanitized);

    if (sanitized.isNotEmpty && index < _codeLength - 1) {
      _focusNodes[index + 1].requestFocus();
    }
    if (sanitized.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 48.w,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        textInputAction: index == _codeLength - 1
            ? TextInputAction.done
            : TextInputAction.next,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        cursorColor: AppColors.primaryColor,
        style: AppStyles.black18BoldStyle,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          filled: true,
          fillColor: const Color(0xffF7F8F9),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Color(0xffE8ECF4), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(
              color: AppColors.primaryColor,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: const BorderSide(color: Colors.red, width: 1),
          ),
        ),
        onChanged: (value) => _onDigitChanged(index, value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        _updateControllersFromState(state.digits);

        if (state is OtpError) {
          showMsg(state.message, context, isError: true);
        }

        if (state is OtpSuccess) {
          showMsg(state.message, context);
          if (state.message == 'Code verified successfully') {
            context.pushNamed(AppRoutes.resetPasswordScreen);
          }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(_codeLength, _buildOtpField),
                  ),
                  HeightSpace(24),
                  PrimaryButtonWidget(
                    buttonText: 'Verify Code',
                    isLoading: isLoading,
                    onPress: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      context.read<OtpCubit>().verifyCode();
                    },
                  ),
                  HeightSpace(24),
                  Center(
                    child: TextButton(
                      onPressed: state.canResend
                          ? () {
                              FocusManager.instance.primaryFocus?.unfocus();
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
                              : AppColors.greyColor,
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
