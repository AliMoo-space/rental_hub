import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final Locale locale;
  ChangeLanguageEvent(this.locale);
}

class LocalizationState {
  final Locale locale;
  const LocalizationState(this.locale);
}

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  static const String _languageKey = 'language';
  late SharedPreferences _prefs;

  LocalizationBloc() : super(const LocalizationState(Locale('en'))) {
    on<ChangeLanguageEvent>(_onChangeLanguage);
    _initializePrefs();
  }

  Future<void> _initializePrefs() async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final savedLanguage = _prefs.getString(_languageKey) ?? 'en';
      if (savedLanguage != 'en') {
        add(ChangeLanguageEvent(Locale(savedLanguage)));
      }
    } catch (e) {
      // Silently fail if initialization fails
      _prefs = (await SharedPreferences.getInstance());
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      await _prefs.setString(_languageKey, event.locale.languageCode);
    } catch (e) {
      // Ignore if preferences fail
    }
    emit(LocalizationState(event.locale));
  }

  Locale getCurrentLocale() => state.locale;
}
