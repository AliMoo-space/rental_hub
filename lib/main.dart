import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/routing/router_generation_config.dart';
import 'package:rental_hub/core/styling/theme_data.dart';
import 'package:rental_hub/l10n/generated/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  final localeCubit = getIt<LocaleCubit>();
  final themeCubit = getIt<ThemeCubit>();
  await localeCubit.loadInitialLocale(
    supportedLocales: AppLocalizations.supportedLocales,
  );

  runApp(MyApp(localeCubit: localeCubit, themeCubit: themeCubit));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.localeCubit, required this.themeCubit, super.key});

  final LocaleCubit localeCubit;
  final ThemeCubit themeCubit;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: localeCubit),
        BlocProvider.value(value: themeCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(402, 889),
        minTextAdapt: true,
        builder: (context, child) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, localeState) {
                return BlocBuilder<ThemeCubit, ThemeState>(
                  builder: (context, themeState) {
                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      theme: AppThemes.lightTheme,
                      darkTheme: AppThemes.darkTheme,
                      themeMode: themeState.themeMode,
                      routerConfig: RouterGenerationConfig.goRouter,
                      locale: localeState.locale,
                      supportedLocales: AppLocalizations.supportedLocales,
                      localizationsDelegates:
                          AppLocalizations.localizationsDelegates,
                      localeResolutionCallback:
                          (deviceLocale, supportedLocales) =>
                              _resolveDeviceLocale(deviceLocale),
                      builder: (context, child) => SafeArea(child: child!),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
