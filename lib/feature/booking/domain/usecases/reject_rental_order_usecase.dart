import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class RejectRentalOrderUseCase {
  final BookingRepository repository;

  RejectRentalOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id, {String? reason}) async {
    return await repository.rejectRentalOrder(id, reason: reason);
  }
}
