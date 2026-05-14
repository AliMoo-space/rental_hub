import 'package:rental_hub/feature/favorites/domain/entities/favorite_entity.dart';

class FavoriteModel extends FavoriteEntity {
  FavoriteModel({required super.favoriteId, required super.message});

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      favoriteId: json['favoriteId'],
      message: json['message'] ?? '',
    );
  }
}
