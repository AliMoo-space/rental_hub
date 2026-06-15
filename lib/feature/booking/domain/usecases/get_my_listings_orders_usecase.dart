import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class GetMyListingsOrdersUseCase {
  final BookingRepository repository;

  GetMyListingsOrdersUseCase({required this.repository});

  Future<Either<Failure, List<RentalOrderEntity>>> call({String? status, int pageNumber = 1, int pageSize = 10}) async {
    return await repository.getMyListingsOrders(status: status, pageNumber: pageNumber, pageSize: pageSize);
  }
}
