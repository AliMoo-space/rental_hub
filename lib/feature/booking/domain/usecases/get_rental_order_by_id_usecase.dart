import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class GetRentalOrderByIdUseCase {
  final BookingRepository repository;

  GetRentalOrderByIdUseCase({required this.repository});

  Future<Either<Failure, RentalOrderEntity>> call(int id) async {
    return await repository.getRentalOrderById(id);
  }
}
