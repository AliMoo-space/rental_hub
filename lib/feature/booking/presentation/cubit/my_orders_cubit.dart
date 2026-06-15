import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/domain/usecases/get_my_listings_orders_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/get_my_orders_usecase.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/my_orders_state.dart';

class MyOrdersCubit extends Cubit<MyOrdersState> {
  final GetMyOrdersUseCase getMyOrdersUseCase;
  final GetMyListingsOrdersUseCase getMyListingsOrdersUseCase;

  int _page = 1;
  bool _isFetching = false;
  final int _pageSize = 10;
  String? _currentStatus;

  MyOrdersCubit({
    required this.getMyOrdersUseCase,
    required this.getMyListingsOrdersUseCase,
  }) : super(MyOrdersInitial());

  Future<void> loadMyOrders({bool refresh = false, String? status}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (refresh || status != _currentStatus) {
      _page = 1;
      _currentStatus = status;
      emit(MyOrdersLoading([], isFirstFetch: true));
    } else {
      final currentState = state;
      if (currentState is MyOrdersLoaded && currentState.hasReachedMax) {
        _isFetching = false;
        return;
      }
      if (currentState is MyOrdersLoaded) {
        emit(MyOrdersLoading(currentState.orders));
      }
    }

    final result = await getMyOrdersUseCase(
      status: _currentStatus,
      pageNumber: _page,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        emit(MyOrdersFailure(errMessage: failure.errMessage));
        _isFetching = false;
      },
      (newOrders) {
        _page++;
        final currentState = state;
        List<RentalOrderEntity> allOrders = [];
        if (currentState is MyOrdersLoading) {
          allOrders = currentState.oldOrders;
        } else if (currentState is MyOrdersLoaded) {
          allOrders = currentState.orders;
        }

        allOrders.addAll(newOrders);
        emit(MyOrdersLoaded(allOrders, hasReachedMax: newOrders.length < _pageSize));
        _isFetching = false;
      },
    );
  }

  Future<void> loadMyListingsOrders({bool refresh = false, String? status}) async {
    if (_isFetching) return;
    _isFetching = true;

    if (refresh || status != _currentStatus) {
      _page = 1;
      _currentStatus = status;
      emit(MyOrdersLoading([], isFirstFetch: true));
    } else {
      final currentState = state;
      if (currentState is MyOrdersLoaded && currentState.hasReachedMax) {
        _isFetching = false;
        return;
      }
      if (currentState is MyOrdersLoaded) {
        emit(MyOrdersLoading(currentState.orders));
      }
    }

    final result = await getMyListingsOrdersUseCase(
      status: _currentStatus,
      pageNumber: _page,
      pageSize: _pageSize,
    );

    result.fold(
      (failure) {
        emit(MyOrdersFailure(errMessage: failure.errMessage));
        _isFetching = false;
      },
      (newOrders) {
        _page++;
        final currentState = state;
        List<RentalOrderEntity> allOrders = [];
        if (currentState is MyOrdersLoading) {
          allOrders = currentState.oldOrders;
        } else if (currentState is MyOrdersLoaded) {
          allOrders = currentState.orders;
        }

        allOrders.addAll(newOrders);
        emit(MyOrdersLoaded(allOrders, hasReachedMax: newOrders.length < _pageSize));
        _isFetching = false;
      },
    );
  }
}
