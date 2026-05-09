import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/repo/category_repo.dart';

class GetCategory {
  final CategoryRepo categoryRepo;

  GetCategory({required this.categoryRepo});

  Future<Either<Failure, List<CategoryEntity>>> call() async {
    return await categoryRepo.getCategories();
  }
}