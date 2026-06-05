import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/owner_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_rental_request_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_stats_entity.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';

abstract class MyProductsRepo {
  Future<Either<Failure, ProductsEntity>> getMyProducts({required int pageNumber});
  Future<Either<Failure, String>> deleteProduct({required int id});
  Future<Either<Failure, String>> suspendProduct({required int id});
  Future<Either<Failure, String>> activateProduct({required int id});
  Future<Either<Failure, OwnerStatsEntity>> getOwnerStats();
  Future<Either<Failure, ProductStatsEntity>> getProductStats({required int id});
  Future<Either<Failure, List<ProductTransactionEntity>>> getProductTransactions({required int id});
  Future<Either<Failure, List<ProductRentalRequestEntity>>> getProductRentalRequests({required int id});
}
