import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class GetRenterOrderStatsUseCase {
  final BookingRepository repository;

  GetRenterOrderStatsUseCase({required this.repository});

  Future<Either<Failure, RentalOrderStatsEntity>> call() async {
    return await repository.getRenterOrderStats();
  }
}
