import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/feature/auth/presentation/widgets/animated_auth_toggle.dart';

class RouterGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.animatedAuthToggle,
    routes: [
      GoRoute(
        name: AppRoutes.animatedAuthToggle,
        path: AppRoutes.animatedAuthToggle,
        builder: (context, state) => const AnimatedAuthToggle(),
      ),
      // GoRoute(
      //   name: AppRoutes.loginScreen,
      //   path: AppRoutes.loginScreen,
      //   builder: (context, state) => BlocProvider(
      //     create: (context) => getIt<AuthCubit>(),
      //     child: const LoginScreen(),
      //   ),
      // ),
    ],
  );
}
