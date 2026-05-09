import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/data/datasource/category_remote_data_source.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/category_repo.dart';

class CategoryRepoImpl implements CategoryRepo {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      print('Categories loaded successfully: ${categories.items.length} items');
      return Right([categories]);
    } on ServerException catch (e) {
      print('ServerException: ${e.errorModel.firstErrorMessage}');
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      print('General Exception: $e');
      print('StackTrace: ${e.runtimeType}');
      return Left(Failure(errMessage: 'فشل تحميل التصنيفات: ${e.toString()}'));
    }
  }
}
