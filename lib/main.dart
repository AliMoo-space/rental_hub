import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/routing/router_generation_config.dart';
import 'package:rental_hub/core/styling/theme_data.dart';
import 'package:rental_hub/l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  final localeCubit = getIt<LocaleCubit>();
  await localeCubit.loadInitialLocale(
    supportedLocales: AppLocalizations.supportedLocales,
  );

  runApp(MyApp(localeCubit: localeCubit));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.localeCubit, super.key});

  final LocaleCubit localeCubit;

  Locale _resolveDeviceLocale(Locale? locale) {
    if (locale == null) {
      return const Locale('en');
    }
    for (final supported in AppLocalizations.supportedLocales) {
      if (supported.languageCode == locale.languageCode) {
        return supported;
      }
    }
    return const Locale('en');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: localeCubit,
      child: ScreenUtilInit(
        designSize: const Size(402, 889),
        minTextAdapt: true,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: AppThemes.lightTheme,
                  routerConfig: RouterGenerationConfig.goRouter,
                  locale: state.locale,
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  localeResolutionCallback: (deviceLocale, supportedLocales) =>
                      _resolveDeviceLocale(deviceLocale),
                  builder: (context, child) => SafeArea(child: child!),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
