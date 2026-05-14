import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/favorites/data/datasource/favorite_remote_data_source.dart';
import 'package:rental_hub/feature/favorites/domain/entities/favorite_entity.dart';
import 'package:rental_hub/feature/favorites/domain/repo/favorite_repo.dart';

class FavoriteRepoImp implements FavoriteRepo {
  final FavoriteRemoteDataSource favoriteRemoteDataSource;

  FavoriteRepoImp({required this.favoriteRemoteDataSource});
  @override
  Future<Either<Failure, FavoriteEntity>> addToFavorite({
    required int productId,
  }) async {
    try {
      final favorite = await favoriteRemoteDataSource.addToFavorite(
        productId: productId,
      );
      return Right(favorite);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FavoriteEntity>> removeFavorite({
    required int productId,
  }) async {
    try {
      final favorite = await favoriteRemoteDataSource.removeFavorite(
        productId: productId,
      );
      return Right(favorite);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
