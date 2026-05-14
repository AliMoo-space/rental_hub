import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/favorites/domain/entities/favorite_entity.dart';

abstract class FavoriteRepo {
  Future<Either<Failure, FavoriteEntity>> addToFavorite({
    required int productId,
  });

  Future<Either<Failure, FavoriteEntity>> removeFavorite({
    required int productId,
  });
}
