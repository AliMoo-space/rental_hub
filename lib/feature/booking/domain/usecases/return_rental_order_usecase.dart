import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class ReturnRentalOrderUseCase {
  final BookingRepository repository;

  ReturnRentalOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id, {String? reason}) async {
    return await repository.returnRentalOrder(id, reason: reason);
  }
}
