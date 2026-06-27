import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/booking/domain/usecases/get_renter_order_stats_usecase.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/renter_stats_state.dart';

class RenterStatsCubit extends Cubit<RenterStatsState> {
  final GetRenterOrderStatsUseCase getStatsUseCase;

  RenterStatsCubit({required this.getStatsUseCase})
    : super(RenterStatsInitial());

  Future<void> loadStats() async {
    emit(RenterStatsLoading());
    final result = await getStatsUseCase();
    result.fold(
      (failure) => emit(RenterStatsFailure(errMessage: failure.errMessage)),
      (stats) => emit(RenterStatsLoaded(stats: stats)),
    );
  }
}
