import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

abstract class BookingActionState extends Equatable {}

class BookingActionInitial extends BookingActionState {
  @override
  List<Object?> get props => [];
}

class BookingActionLoading extends BookingActionState {
  @override
  List<Object?> get props => [];
}

class BookingActionSuccess extends BookingActionState {
  final RentalOrderEntity? order;
  final String errMessage;
  BookingActionSuccess({this.order, required this.errMessage});

  @override
  List<Object?> get props => [order, errMessage];
}

class BookingActionFailure extends BookingActionState {
  final String errMessage;
  BookingActionFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
