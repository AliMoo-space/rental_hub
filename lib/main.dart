import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/routing/router_generation_config.dart';
import 'package:rental_hub/core/styling/theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 1007),
      minTextAdapt: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: AppThemes.lightTheme,
            routerConfig: RouterGenerationConfig.goRouter,
            builder: (context, child) => SafeArea(child: child!),
          ),
        );
      },
    );
  }
}
