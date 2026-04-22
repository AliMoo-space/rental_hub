abstract class LocaleRepository {
  Future<String?> getSavedLocaleCode();

  Future<void> saveLocaleCode(String languageCode);
}
