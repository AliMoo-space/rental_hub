import 'dart:developer' as developer;
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/favorites/data/model/favorite_model.dart';
import 'package:rental_hub/feature/favorites/data/model/favorites_item_model.dart';

abstract class FavoriteRemoteDataSource {
  Future<FavoriteModel> addToFavorite({required int productId});
  Future<FavoriteResponseModel> getFavorites({required int page});

  Future<FavoriteModel> removeFavorite({required int productId});
}

class FavoriteRemoteDataSourceImp implements FavoriteRemoteDataSource {
  final ApiConsumer _api;
  FavoriteRemoteDataSourceImp(this._api);

  @override
  Future<FavoriteModel> addToFavorite({required int productId}) async {
    developer.log(
      ' FavoriteRemoteDataSourceImp.addToFavorite: productId=$productId',
      name: 'Favorites',
    );

    final response = await _api.post(
      EndPoints.favoritesEndpoint,
      data: {'productId': productId},
    );

    // CRITICAL: Pass response.data to ResponseParser, not the entire Response object
    final payload = ResponseParser.extractDataPayload(response.data);

    developer.log(
      'FavoriteRemoteDataSourceImp.addToFavorite: Success\n'
      'Payload: $payload',
      name: 'Favorites',
    );

    return FavoriteModel.fromJson(payload);
  }

  @override
  Future<FavoriteModel> removeFavorite({required int productId}) async {
    developer.log(
      'FavoriteRemoteDataSourceImp.removeFavorite: productId=$productId',
      name: 'Favorites',
    );

    final endpoint = '${EndPoints.favoritesEndpoint}/$productId';
    final response = await _api.delete(endpoint);

    final payload = ResponseParser.extractDataPayload(response.data);
    final responsePayload = payload.isNotEmpty
        ? payload
        : {
            'favoriteId': productId,
            'message': response.statusCode == 204
                ? 'Favorite removed successfully'
                : 'Success',
          };

    developer.log(
      'FavoriteRemoteDataSourceImp.removeFavorite: Success\n'
      'Endpoint: $endpoint\n'
      'Payload: $responsePayload',
      name: 'Favorites',
    );

    return FavoriteModel.fromJson(responsePayload);
  }

  @override
  Future<FavoriteResponseModel> getFavorites({required int page}) async {
    try {
      developer.log(
        'FavoriteRemoteDataSourceImp.getFavorites: Fetching favorites\n'
        'Page: $page',
        name: 'Favorites',
      );

      final response = await _api.get(
        EndPoints.favoritesEndpoint,
        queryParameters: {'page': page, 'pageSize': 10},
      );

      final payload = ResponseParser.extractDataPayload(response.data);

      developer.log(
        'FavoriteRemoteDataSourceImp.getFavorites: Success\n'
        'Page: $page\n'
        'Payload: $payload',
        name: 'Favorites',
      );

      return FavoriteResponseModel.fromJson(payload);
    } catch (e) {
      developer.log(
        'FavoriteRemoteDataSourceImp.getFavorites: Error fetching favorites\n'
        'Page: $page\n'
        'Error: $e',
        name: 'Favorites',
      );
      rethrow;
    }
  }
}
