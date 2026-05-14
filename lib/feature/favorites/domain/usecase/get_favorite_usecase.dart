import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/favorites/data/model/favorites_item_model.dart';
import 'package:rental_hub/feature/favorites/domain/repo/favorite_repo.dart';

class GetFavorites {
  final FavoriteRepo repo;

  GetFavorites(this.repo);

  Future<Either<Failure, FavoriteResponseModel>> call(int page) {
    return repo.getFavorites(page: page);
  }
}
