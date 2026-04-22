import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';

class SaveLocaleUseCase {
  SaveLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<void> call(String languageCode) {
    return _repository.saveLocaleCode(languageCode);
  }
}
