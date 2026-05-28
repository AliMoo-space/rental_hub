import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/repositories/search_repository.dart';

class SearchProductsUseCase {
  final SearchRepository repository;

  SearchProductsUseCase(this.repository);

  Future<Either<Failure, SearchResultEntity>> call({
    required String query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    required int pageNumber,
    int pageSize = 10,
  }) async {
    return repository.searchProducts(
      query: query,
      categoryId: categoryId,
      minPrice: minPrice,
      maxPrice: maxPrice,
      condition: condition,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }
}
