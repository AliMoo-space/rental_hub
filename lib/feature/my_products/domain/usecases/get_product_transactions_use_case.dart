import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';
import 'package:rental_hub/feature/my_products/domain/repo/my_products_repo.dart';

class GetProductTransactionsUseCase {
  final MyProductsRepo repo;

  GetProductTransactionsUseCase(this.repo);

  Future<Either<Failure, List<ProductTransactionEntity>>> call({
    required int id,
  }) {
    return repo.getProductTransactions(id: id);
  }
}
