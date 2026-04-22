import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  LocaleRepositoryImpl(this._cacheHelper);

  static const String _localeKey = 'app_locale_code';

  final CacheHelper _cacheHelper;

  @override
  Future<String?> getSavedLocaleCode() async {
    return _cacheHelper.getString(key: _localeKey);
  }

  @override
  Future<void> saveLocaleCode(String languageCode) async {
    await _cacheHelper.saveData(key: _localeKey, value: languageCode);
  }
}
