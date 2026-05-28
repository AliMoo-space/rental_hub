import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<CategoryEntity>>> getCategories();

  Future<Either<Failure, List<SubCategoryEntity>>> getSubcategories(
    int categoryId,
  );
}
