import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/favorites/domain/entities/favorite_entity.dart';
import 'package:rental_hub/feature/favorites/domain/repo/favorite_repo.dart';

class RemoveFavoriteUseCase {
  final FavoriteRepo favoriteRepo;

  RemoveFavoriteUseCase({required this.favoriteRepo});

  Future<Either<Failure, FavoriteEntity>> call({required int productId}) {
    return favoriteRepo.removeFavorite(productId: productId);
  }
}
