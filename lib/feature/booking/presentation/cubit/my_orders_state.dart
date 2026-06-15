import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';

abstract class MyOrdersState {}

class MyOrdersInitial extends MyOrdersState {}

class MyOrdersLoading extends MyOrdersState {
  final List<RentalOrderEntity> oldOrders;
  final bool isFirstFetch;

  MyOrdersLoading(this.oldOrders, {this.isFirstFetch = false});
}

class MyOrdersLoaded extends MyOrdersState {
  final List<RentalOrderEntity> orders;
  final bool hasReachedMax;

  MyOrdersLoaded(this.orders, {this.hasReachedMax = false});
}

class MyOrdersFailure extends MyOrdersState {
  final String errMessage;
  MyOrdersFailure({required this.errMessage});
}
