import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/screens/auth_success_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/forgot_password_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/otp_verification_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/animated_auth_toggle.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.animatedAuthToggle,
    routes: [
      GoRoute(
        name: AppRoutes.animatedAuthToggle,
        path: AppRoutes.animatedAuthToggle,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<LoginCubit>(),
          child: const AnimatedAuthToggle(),
        ),
      ),
      GoRoute(
        name: AppRoutes.forgotPasswordScreen,
        path: AppRoutes.forgotPasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ForgotPasswordCubit>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.otpVerificationScreen,
        path: AppRoutes.otpVerificationScreen,
        builder: (context, state) {
          final email = (state.extra is String) ? state.extra! as String : '';
          return BlocProvider(
            create: (context) => OtpCubit(),
            child: OtpVerificationScreen(email: email),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.resetPasswordScreen,
        path: AppRoutes.resetPasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => ResetPasswordCubit(),
          child: const ResetPasswordScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.authSuccessScreen,
        path: AppRoutes.authSuccessScreen,
        builder: (context, state) => const AuthSuccessScreen(),
      ),
    ],
  );
}
