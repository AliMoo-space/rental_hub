import 'package:dio/dio.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/search/data/models/live_suggestion_model.dart';

abstract class AiSearchRemoteDataSource {
  Future<List<LiveSuggestionModel>> liveSearch(
    String query, {
    CancelToken? cancelToken,
  });
}

class AiSearchRemoteDataSourceImpl implements AiSearchRemoteDataSource {
  final ApiConsumer apiConsumer;

  AiSearchRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<LiveSuggestionModel>> liveSearch(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final response = await apiConsumer.get(
      '${EndPoints.aiBaseUrl}/search/live',
      queryParameters: {'q': query},
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    final products = payload['products'] as List<dynamic>? ?? [];
    return products
        .map((e) => LiveSuggestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
