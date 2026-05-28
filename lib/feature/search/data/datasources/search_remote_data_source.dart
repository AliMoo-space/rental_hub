import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/search/data/models/search_result_model.dart';

abstract class SearchRemoteDataSource {
  Future<SearchResultModel> searchProducts({
    required String query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    required int pageNumber,
    int pageSize = 10,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiConsumer apiConsumer;

  SearchRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<SearchResultModel> searchProducts({
    required String query,
    int? categoryId,
    double? minPrice,
    double? maxPrice,
    String? condition,
    required int pageNumber,
    int pageSize = 10,
  }) async {
    final response = await apiConsumer.get(
      EndPoints.productsEndpoint,
      queryParameters: {
        'Search': query,
        'CategoryId': categoryId,
        'MinPrice': minPrice,
        'MaxPrice': maxPrice,
        'Condition': condition,
        'PageNumber': pageNumber,
        'PageSize': pageSize,
      },
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    return SearchResultModel.fromJson(payload);
  }
}
