import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

abstract class OrderDetailState extends Equatable {}

class OrderDetailInitial extends OrderDetailState {
  @override
  List<Object?> get props => [];
}

class OrderDetailLoading extends OrderDetailState {
  @override
  List<Object?> get props => [];
}

class OrderDetailLoaded extends OrderDetailState {
  final RentalOrderEntity order;
  final String currentUserId;

  OrderDetailLoaded({required this.order, required this.currentUserId});

  @override
  List<Object?> get props => [order, currentUserId];
}

class OrderDetailFailure extends OrderDetailState {
  final String errMessage;

  OrderDetailFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
