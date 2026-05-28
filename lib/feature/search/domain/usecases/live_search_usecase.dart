import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';
import 'package:rental_hub/feature/search/domain/repositories/search_repository.dart';

class LiveSearchUseCase {
  final SearchRepository repository;

  LiveSearchUseCase(this.repository);

  Future<Either<Failure, List<LiveSuggestionEntity>>> call(String query) async {
    return repository.liveSearch(query);
  }
}
