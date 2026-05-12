import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.themeMode});

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class ThemeCubit extends Cubit<ThemeState> {
  static const _cacheKey = 'is_dark_mode';

  ThemeCubit(this._cacheHelper)
    : super(const ThemeState(themeMode: ThemeMode.system)) {
    final stored = _cacheHelper.getBool(key: _cacheKey);
    if (stored != null) {
      emit(ThemeState(themeMode: stored ? ThemeMode.dark : ThemeMode.light));
    }
  }

  final CacheHelper _cacheHelper;

  Future<void> toggleTheme() async {
    final isDark = state.themeMode == ThemeMode.dark;
    final newMode = isDark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeState(themeMode: newMode));
    await _cacheHelper.saveData(
      key: _cacheKey,
      value: newMode == ThemeMode.dark,
    );
  }

  Future<void> setTheme(ThemeMode themeMode) async {
    emit(ThemeState(themeMode: themeMode));
    await _cacheHelper.saveData(
      key: _cacheKey,
      value: themeMode == ThemeMode.dark,
    );
  }
}
