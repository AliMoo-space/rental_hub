import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class SuspendProductUseCase {
  final MyProductsRepo repo;

  SuspendProductUseCase(this.repo);

  Future<Either<Failure, String>> call({required int id}) {
    return repo.suspendProduct(id: id);
  }
}
