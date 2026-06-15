import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

abstract class BookingActionState {}

class BookingActionInitial extends BookingActionState {}

class BookingActionLoading extends BookingActionState {}

class BookingActionSuccess extends BookingActionState {
  final RentalOrderEntity? order;
  final String errMessage;
  BookingActionSuccess({this.order, required this.errMessage});
}

class BookingActionFailure extends BookingActionState {
  final String errMessage;
  BookingActionFailure({required this.errMessage});
}
