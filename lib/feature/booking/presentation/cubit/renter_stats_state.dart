import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_stats_entity.dart';

abstract class RenterStatsState extends Equatable {}

class RenterStatsInitial extends RenterStatsState {
  @override
  List<Object?> get props => [];
}

class RenterStatsLoading extends RenterStatsState {
  @override
  List<Object?> get props => [];
}

class RenterStatsLoaded extends RenterStatsState {
  final RentalOrderStatsEntity stats;

  RenterStatsLoaded({required this.stats});

  @override
  List<Object?> get props => [stats];
}

class RenterStatsFailure extends RenterStatsState {
  final String errMessage;

  RenterStatsFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
