import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/domain/usecases/approve_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/cancel_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/confirm_receipt_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/create_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/reject_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/return_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/domain/usecases/ship_rental_order_usecase.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_state.dart';

class BookingActionCubit extends Cubit<BookingActionState> {
  final CreateRentalOrderUseCase createOrderUseCase;
  final ApproveRentalOrderUseCase approveOrderUseCase;
  final RejectRentalOrderUseCase rejectOrderUseCase;
  final CancelRentalOrderUseCase cancelOrderUseCase;
  final ShipRentalOrderUseCase shipOrderUseCase;
  final ConfirmReceiptRentalOrderUseCase confirmReceiptOrderUseCase;
  final ReturnRentalOrderUseCase returnOrderUseCase;

  BookingActionCubit({
    required this.createOrderUseCase,
    required this.approveOrderUseCase,
    required this.rejectOrderUseCase,
    required this.cancelOrderUseCase,
    required this.shipOrderUseCase,
    required this.confirmReceiptOrderUseCase,
    required this.returnOrderUseCase,
  }) : super(BookingActionInitial());

  Future<void> createRentalOrder(CreateRentalOrderDto dto) async {
    emit(BookingActionLoading());
    final result = await createOrderUseCase(dto);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (order) => emit(BookingActionSuccess(order: order, errMessage: "تم إنشاء الطلب بنجاح")),
    );
  }

  Future<void> approveOrder(int id) async {
    emit(BookingActionLoading());
    final result = await approveOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم الموافقة على الطلب")),
    );
  }

  Future<void> rejectOrder(int id) async {
    emit(BookingActionLoading());
    final result = await rejectOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم رفض الطلب")),
    );
  }

  Future<void> cancelOrder(int id) async {
    emit(BookingActionLoading());
    final result = await cancelOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم إلغاء الطلب")),
    );
  }

  Future<void> shipOrder(int id) async {
    emit(BookingActionLoading());
    final result = await shipOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم شحن الطلب")),
    );
  }

  Future<void> confirmReceiptOrder(int id) async {
    emit(BookingActionLoading());
    final result = await confirmReceiptOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم تأكيد الاستلام")),
    );
  }

  Future<void> returnOrder(int id) async {
    emit(BookingActionLoading());
    final result = await returnOrderUseCase(id);
    result.fold(
      (failure) => emit(BookingActionFailure(errMessage: failure.errMessage)),
      (_) => emit(BookingActionSuccess(errMessage: "تم إرجاع الطلب")),
    );
  }
}
