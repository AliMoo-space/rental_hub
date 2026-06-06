import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class DeleteProductUseCase {
  final MyProductsRepo repo;

  DeleteProductUseCase(this.repo);

  Future<Either<Failure, String>> call({required int id}) {
    return repo.deleteProduct(id: id);
  }
}
