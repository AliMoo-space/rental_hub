import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/add_listing/presentation/screens/add_listing_screen.dart';
import 'package:rental_hub/feature/ai_chat/presentation/cubit/ai_chat_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/forgot_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/otp_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:rental_hub/feature/auth/presentation/screens/auth_success_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/forgot_password_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/otp_verification_screen.dart';
import 'package:rental_hub/feature/auth/presentation/screens/reset_password_screen.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/animated_auth_toggle.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_flow_screen.dart';
import 'package:rental_hub/feature/ai_chat/presentation/screens/ai_chat_screen.dart';
import 'package:rental_hub/feature/deals/presentation/screens/deals_screen.dart';
import 'package:rental_hub/feature/favorites/presentation/cubit/favorite_cubit.dart';
import 'package:rental_hub/feature/favorites/presentation/screens/favorites_screen.dart';
import 'package:rental_hub/feature/intro/intro_screen.dart';
import 'package:rental_hub/feature/main/main_screen.dart';
import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:rental_hub/feature/product_details/presentation/screens/product_details_screen.dart';
import 'package:rental_hub/feature/profile/presentation/screens/edit_profile_screen.dart';
import 'package:rental_hub/feature/profile/presentation/screens/settings_screen.dart';
import 'package:rental_hub/feature/community/presentation/screens/community_screen.dart';
import 'package:rental_hub/feature/splash/splash_view.dart';
import 'package:rental_hub/feature/wallet/presentation/screens/wallet_screen.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    // initialLocation: AppRoutes.mainScreen,
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.introScreen,
        path: AppRoutes.introScreen,
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        name: AppRoutes.animatedAuthToggle,
        path: AppRoutes.animatedAuthToggle,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt<LoginCubit>()),
            BlocProvider(create: (context) => getIt<SignUpCubit>()),
          ],
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
            create: (context) => getIt<OtpCubit>(param1: email),
            child: OtpVerificationScreen(email: email),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.resetPasswordScreen,
        path: AppRoutes.resetPasswordScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<ResetPasswordCubit>(),
          child: const ResetPasswordScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.authSuccessScreen,
        path: AppRoutes.authSuccessScreen,
        builder: (context, state) => const AuthSuccessScreen(),
      ),
      GoRoute(
        name: AppRoutes.mainScreen,
        path: AppRoutes.mainScreen,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        name: AppRoutes.productDetailsScreen,
        path: '${AppRoutes.productDetailsPath}/:id',
        builder: (context, state) {
          return BlocProvider(
            create: (context) {
              final id = int.parse(state.pathParameters['id'] ?? '');
              return getIt<ProductDetailsCubit>()..fetchProductDetails(id);
            },
            child: const ProductDetailsScreen(),
          );
        },
      ),
      GoRoute(
        name: AppRoutes.bookingFlowScreen,
        path: AppRoutes.bookingFlowScreen,
        builder: (context, state) => const BookingFlowScreen(),
      ),
      GoRoute(
        name: AppRoutes.editProfileScreen,
        path: AppRoutes.editProfileScreen,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        name: AppRoutes.settingsScreen,
        path: AppRoutes.settingsScreen,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        name: AppRoutes.communityScreen,
        path: AppRoutes.communityScreen,
        builder: (context, state) => const CommunityScreen(),
      ),

      GoRoute(
        name: AppRoutes.favoritesScreen,
        path: AppRoutes.favoritesScreen,
        builder: (context, state) => BlocProvider(
          create: (context) => getIt<FavoriteCubit>(),
          child: const FavoritesScreen(),
        ),
      ),
      GoRoute(
        name: AppRoutes.dealsScreen,
        path: AppRoutes.dealsScreen,
        builder: (context, state) => const DealsScreen(),
      ),
      GoRoute(
        name: AppRoutes.walletScreen,
        path: AppRoutes.walletScreen,
        builder: (context, state) => const WalletScreen(),
      ),
      GoRoute(
        name: AppRoutes.addListingScreen,
        path: AppRoutes.addListingScreen,
        builder: (context, state) => const AddListingScreen(),
      ),
      GoRoute(
        name: AppRoutes.aiChatScreen,
        path: AppRoutes.aiChatScreen,
        builder: (context, state) => const AiChatScreen(),
      ),
    ],
  );
}
