import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class ApproveRentalOrderUseCase {
  final BookingRepository repository;

  ApproveRentalOrderUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id) async {
    return await repository.approveRentalOrder(id);
  }
}
