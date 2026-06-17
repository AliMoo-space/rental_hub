import 'dart:math';
import 'package:dio/dio.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/databases/cache/cache_helper.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/search/data/models/live_suggestion_model.dart';
import 'package:rental_hub/feature/search/data/models/search_result_model.dart';

abstract class AiSearchRemoteDataSource {
  Future<List<LiveSuggestionModel>> liveSearch(
    String query, {
    CancelToken? cancelToken,
  });
  Future<SearchResultModel> getRecommendations();
}

class AiSearchRemoteDataSourceImpl implements AiSearchRemoteDataSource {
  final ApiConsumer apiConsumer;
  final TokenStorageHelper tokenStorageHelper;
  final CacheHelper cacheHelper;

  AiSearchRemoteDataSourceImpl({
    required this.apiConsumer,
    required this.tokenStorageHelper,
    required this.cacheHelper,
  });

  @override
  Future<List<LiveSuggestionModel>> liveSearch(
    String query, {
    CancelToken? cancelToken,
  }) async {
    final response = await apiConsumer.get(
      '/search/live',
      queryParameters: {'q': query},
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    final products = payload['products'] as List<dynamic>? ?? [];
    return products
        .map((e) => LiveSuggestionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<SearchResultModel> getRecommendations() async {
    final userId = await tokenStorageHelper.getCurrentUserId();

    final Map<String, dynamic> queryParams = {};
    if (userId != null && userId.isNotEmpty) {
      queryParams['user_id'] = userId;
    } else {
      String? sessionId = cacheHelper.getString(key: 'session_id');
      if (sessionId == null) {
        sessionId = _generateSessionId();
        await cacheHelper.saveData(key: 'session_id', value: sessionId);
      }
      queryParams['session_id'] = sessionId;
    }

    final response = await apiConsumer.get(
      EndPoints.recommendationsEndpoint,
      queryParameters: queryParams,
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    return SearchResultModel.fromRecommendationsJson(payload);
  }

  String _generateSessionId() {
    final random = Random();
    final part1 = DateTime.now().microsecondsSinceEpoch;
    final part2 = random.nextInt(1000000);
    return 'sess_${part1}_$part2';
  }
}
