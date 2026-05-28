import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/category_repo.dart';

class GetSubcategoriesUseCase {
  const GetSubcategoriesUseCase({required this.categoryRepo});

  final CategoryRepo categoryRepo;

  Future<Either<Failure, List<SubCategoryEntity>>> call(int categoryId) {
    return categoryRepo.getSubcategories(categoryId);
  }
}
