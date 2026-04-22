import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/localization/domain/usecases/get_saved_locale_use_case.dart';
import 'package:rental_hub/feature/localization/domain/usecases/save_locale_use_case.dart';

class LocaleState extends Equatable {
  const LocaleState(this.locale);

  final Locale locale;

  @override
  List<Object> get props => [locale.languageCode];
}

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit(this._getSavedLocaleUseCase, this._saveLocaleUseCase)
    : super(const LocaleState(Locale('en')));

  final GetSavedLocaleUseCase _getSavedLocaleUseCase;
  final SaveLocaleUseCase _saveLocaleUseCase;

  Future<void> loadInitialLocale({
    required List<Locale> supportedLocales,
  }) async {
    final savedLanguageCode = await _getSavedLocaleUseCase();
    final Locale deviceLocale =
        WidgetsBinding.instance.platformDispatcher.locale;

    final resolvedLocale = _resolveLocale(
      supportedLocales: supportedLocales,
      savedLanguageCode: savedLanguageCode,
      deviceLocale: deviceLocale,
    );

    if (resolvedLocale.languageCode != state.locale.languageCode) {
      emit(LocaleState(resolvedLocale));
    }
  }

  Future<void> toggleLanguage(List<Locale> supportedLocales) async {
    if (supportedLocales.isEmpty) {
      return;
    }

    final int currentIndex = supportedLocales.indexWhere(
      (locale) => locale.languageCode == state.locale.languageCode,
    );

    final int nextIndex = currentIndex == -1
        ? 0
        : (currentIndex + 1) % supportedLocales.length;
    final Locale nextLocale = supportedLocales[nextIndex];

    await _saveLocaleUseCase(nextLocale.languageCode);
    emit(LocaleState(nextLocale));
  }

  Future<void> setLanguage({
    required String languageCode,
    required List<Locale> supportedLocales,
  }) async {
    final Locale? selectedLocale = _findSupportedLocale(
      supportedLocales,
      languageCode,
    );

    if (selectedLocale == null) {
      return;
    }

    if (selectedLocale.languageCode == state.locale.languageCode) {
      return;
    }

    await _saveLocaleUseCase(selectedLocale.languageCode);
    emit(LocaleState(selectedLocale));
  }

  Locale _resolveLocale({
    required List<Locale> supportedLocales,
    required String? savedLanguageCode,
    required Locale deviceLocale,
  }) {
    final Locale? fromSaved = _findSupportedLocale(
      supportedLocales,
      savedLanguageCode,
    );
    if (fromSaved != null) {
      return fromSaved;
    }

    final Locale? fromDevice = _findSupportedLocale(
      supportedLocales,
      deviceLocale.languageCode,
    );
    if (fromDevice != null) {
      return fromDevice;
    }

    final Locale? englishFallback = _findSupportedLocale(
      supportedLocales,
      'en',
    );
    return englishFallback ?? supportedLocales.first;
  }

  Locale? _findSupportedLocale(
    List<Locale> supportedLocales,
    String? languageCode,
  ) {
    if (languageCode == null || languageCode.isEmpty) {
      return null;
    }

    for (final locale in supportedLocales) {
      if (locale.languageCode == languageCode) {
        return locale;
      }
    }
    return null;
  }
}
