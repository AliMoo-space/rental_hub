import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';

abstract class BookingRepository {
  Future<Either<Failure, RentalOrderEntity>> createRentalOrder(CreateRentalOrderDto dto);
  Future<Either<Failure, RentalOrderStatsEntity>> getRenterOrderStats();
  Future<Either<Failure, List<RentalOrderEntity>>> getMyOrders({String? status, int pageNumber = 1, int pageSize = 10});
  Future<Either<Failure, List<RentalOrderEntity>>> getMyListingsOrders({String? status, int pageNumber = 1, int pageSize = 10});
  Future<Either<Failure, RentalOrderEntity>> getRentalOrderById(int id);
  Future<Either<Failure, void>> approveRentalOrder(int id);
  Future<Either<Failure, void>> rejectRentalOrder(int id);
  Future<Either<Failure, void>> cancelRentalOrder(int id);
  Future<Either<Failure, void>> shipRentalOrder(int id);
  Future<Either<Failure, void>> confirmReceiptRentalOrder(int id);
  Future<Either<Failure, void>> returnRentalOrder(int id);
}
