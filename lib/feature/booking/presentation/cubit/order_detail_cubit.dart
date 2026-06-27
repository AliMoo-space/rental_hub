import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/booking/domain/usecases/get_rental_order_by_id_usecase.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  final GetRentalOrderByIdUseCase getOrderByIdUseCase;

  OrderDetailCubit({required this.getOrderByIdUseCase})
    : super(OrderDetailInitial());

  Future<void> loadOrder(int id, {required String currentUserId}) async {
    emit(OrderDetailLoading());
    final result = await getOrderByIdUseCase(id);
    result.fold(
      (failure) => emit(OrderDetailFailure(errMessage: failure.errMessage)),
      (order) =>
          emit(OrderDetailLoaded(order: order, currentUserId: currentUserId)),
    );
  }
}
