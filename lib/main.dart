import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/routing/router_generation_config.dart';
import 'package:rental_hub/core/styling/theme_data.dart';
import 'package:rental_hub/core/styling/app_constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await setupServiceLocator();
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
