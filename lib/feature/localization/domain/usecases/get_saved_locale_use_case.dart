import 'package:rental_hub/feature/localization/domain/repo/locale_repository.dart';

class GetSavedLocaleUseCase {
  GetSavedLocaleUseCase(this._repository);

  final LocaleRepository _repository;

  Future<String?> call() {
    return _repository.getSavedLocaleCode();
  }
}
