import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class CreateRentalOrderUseCase {
  final BookingRepository repository;

  CreateRentalOrderUseCase({required this.repository});

  Future<Either<Failure, RentalOrderEntity>> call(CreateRentalOrderDto dto) async {
    return await repository.createRentalOrder(dto);
  }
}
