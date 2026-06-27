import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, RentalOrderEntity>> createRentalOrder({
    required int productId,
    required DateTime startDate,
    required DateTime endDate,
    required String deliveryMethod,
    required String street,
    required String city,
    required String governorate,
    required bool termsAgreed,
  });
  Future<Either<Failure, RentalOrderStatsEntity>> getRenterOrderStats();
  Future<Either<Failure, List<RentalOrderEntity>>> getMyOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<Either<Failure, List<RentalOrderEntity>>> getMyListingsOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<Either<Failure, RentalOrderEntity>> getRentalOrderById(int id);
  Future<Either<Failure, void>> approveRentalOrder(int id);
  Future<Either<Failure, void>> rejectRentalOrder(int id, {String? reason});
  Future<Either<Failure, void>> cancelRentalOrder(int id);
  Future<Either<Failure, void>> shipRentalOrder(int id);
  Future<Either<Failure, void>> confirmReceiptRentalOrder(int id);
  Future<Either<Failure, void>> returnRentalOrder(int id, {String? reason});
}
