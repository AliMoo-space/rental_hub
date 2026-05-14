import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';
import 'package:rental_hub/feature/localization/domain/usecases/get_saved_locale_use_case.dart';
import 'package:rental_hub/feature/localization/domain/usecases/save_locale_use_case.dart';
import 'package:rental_hub/feature/localization/presentation/cubit/locale_cubit.dart';
import 'package:rental_hub/feature/theme/presentation/cubit/theme_cubit.dart';
import 'package:rental_hub/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _FakeLocaleRepository implements LocaleRepository {
  String? _languageCode;

  @override
  Future<String?> getSavedLocaleCode() async => _languageCode;

  @override
  Future<void> saveLocaleCode(String languageCode) async {
    _languageCode = languageCode;
  }
}

void main() {
  testWidgets('app builds with locale and theme cubits', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await CacheHelper.init();
    if (!getIt.isRegistered<CacheHelper>()) {
      getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());
    }
    if (!getIt.isRegistered<TokenStorageHelper>()) {
      getIt.registerLazySingleton<TokenStorageHelper>(
        () => TokenStorageHelper(getIt<CacheHelper>()),
      );
    }

    final localeRepository = _FakeLocaleRepository();
    final localeCubit = LocaleCubit(
      GetSavedLocaleUseCase(localeRepository),
      SaveLocaleUseCase(localeRepository),
    );
    final themeCubit = ThemeCubit(CacheHelper());

    await tester.pumpWidget(
      MyApp(localeCubit: localeCubit, themeCubit: themeCubit),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));

    await localeCubit.close();
    await themeCubit.close();
  });
}
