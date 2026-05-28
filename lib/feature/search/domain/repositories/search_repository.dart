import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<LiveSuggestionEntity>>> liveSearch(String query);
  Future<Either<Failure, SearchResultEntity>> searchProducts({
    required String query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    required int pageNumber,
    int pageSize = 10,
  });
}
