import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/search/data/datasources/ai_search_remote_data_source.dart';
import 'package:rental_hub/feature/search/data/datasources/search_remote_data_source.dart';

import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;
  final AiSearchRemoteDataSource aiRemoteDataSource;

  SearchRepositoryImpl(this.remoteDataSource, this.aiRemoteDataSource);

  @override
  Future<Either<Failure, List<LiveSuggestionEntity>>> liveSearch(
    String query,
  ) async {
    try {
      final result = await aiRemoteDataSource.liveSearch(query);
      return Right(result);
    } on ServerException catch (e) {
      if (isNetworkUnavailableException(e)) {
        return Left(Failure(errMessage: friendlyNetworkErrorMessage()));
      }
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل جلب الاقتراحات: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SearchResultEntity>> searchProducts({
    required String query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    required int pageNumber,
    int pageSize = 10,
  }) async {
    try {
      final result = await remoteDataSource.searchProducts(
        query: query,
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        condition: condition,
        pageNumber: pageNumber,
        pageSize: pageSize,
      );
      return Right(result);
    } on ServerException catch (e) {
      if (isNetworkUnavailableException(e)) {
        return Left(Failure(errMessage: friendlyNetworkErrorMessage()));
      }
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'فشل البحث: ${e.toString()}'));
    }
  }
}
