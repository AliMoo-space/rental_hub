import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

abstract class MyOrdersState extends Equatable {}

class MyOrdersInitial extends MyOrdersState {
  @override
  List<Object?> get props => [];
}

class MyOrdersLoading extends MyOrdersState {
  final List<RentalOrderEntity> oldOrders;
  final bool isFirstFetch;

  MyOrdersLoading(this.oldOrders, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldOrders, isFirstFetch];
}

class MyOrdersLoaded extends MyOrdersState {
  final List<RentalOrderEntity> orders;
  final bool hasReachedMax;

  MyOrdersLoaded(this.orders, {this.hasReachedMax = false});

  @override
  List<Object?> get props => [orders, hasReachedMax];
}

class MyOrdersFailure extends MyOrdersState {
  final String errMessage;
  MyOrdersFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
