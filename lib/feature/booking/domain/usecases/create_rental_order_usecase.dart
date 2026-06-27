import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/repositories/booking_repository.dart';

class CreateRentalOrderUseCase {
  final BookingRepository repository;

  CreateRentalOrderUseCase({required this.repository});

  Future<Either<Failure, RentalOrderEntity>> call({
    required int productId,
    required DateTime startDate,
    required DateTime endDate,
    required String deliveryMethod,
    required String street,
    required String city,
    required String governorate,
    required bool termsAgreed,
  }) async {
    return await repository.createRentalOrder(
      productId: productId,
      startDate: startDate,
      endDate: endDate,
      deliveryMethod: deliveryMethod,
      street: street,
      city: city,
      governorate: governorate,
      termsAgreed: termsAgreed,
    );
  }
}
