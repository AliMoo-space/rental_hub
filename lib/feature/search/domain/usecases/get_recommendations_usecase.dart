import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/repositories/search_repository.dart';

class GetRecommendationsUseCase {
  final SearchRepository repository;

  GetRecommendationsUseCase(this.repository);

  Future<Either<Failure, SearchResultEntity>> call() async {
    return repository.getRecommendations();
  }
}
