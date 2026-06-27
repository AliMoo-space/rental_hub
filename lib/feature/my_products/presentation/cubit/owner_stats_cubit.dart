import 'package:bloc/bloc.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/get_owner_stats_use_case.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/get_product_rental_requests_use_case.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/get_product_stats_use_case.dart';
import 'package:rental_hub/feature/my_products/domain/usecases/get_product_transactions_use_case.dart';

import 'owner_stats_state.dart';

class OwnerStatsCubit extends Cubit<OwnerStatsState> {
  final GetOwnerStatsUseCase getOwnerStatsUseCase;
  final GetProductStatsUseCase getProductStatsUseCase;
  final GetProductTransactionsUseCase getProductTransactionsUseCase;
  final GetProductRentalRequestsUseCase getProductRentalRequestsUseCase;

  OwnerStatsCubit(
    this.getOwnerStatsUseCase,
    this.getProductStatsUseCase,
    this.getProductTransactionsUseCase,
    this.getProductRentalRequestsUseCase,
  ) : super(const OwnerStatsState());

  Future<void> loadOwnerStats() async {
    emit(state.copyWith(isOwnerStatsLoading: true, errorMessage: ''));
    final result = await getOwnerStatsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(
          isOwnerStatsLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (ownerStats) => emit(
        state.copyWith(isOwnerStatsLoading: false, ownerStats: ownerStats),
      ),
    );
  }

  Future<void> loadProductStats(int id) async {
    emit(state.copyWith(isProductStatsLoading: true, errorMessage: ''));
    final result = await getProductStatsUseCase(id: id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isProductStatsLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (productStats) => emit(
        state.copyWith(
          isProductStatsLoading: false,
          productStats: productStats,
        ),
      ),
    );
  }

  Future<void> loadProductTransactions(int id) async {
    emit(state.copyWith(isTransactionsLoading: true, errorMessage: ''));
    final result = await getProductTransactionsUseCase(id: id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isTransactionsLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (transactions) => emit(
        state.copyWith(
          isTransactionsLoading: false,
          transactions: transactions,
        ),
      ),
    );
  }

  Future<void> loadProductRentalRequests(int id) async {
    emit(state.copyWith(isRequestsLoading: true, errorMessage: ''));
    final result = await getProductRentalRequestsUseCase(id: id);
    result.fold(
      (failure) => emit(
        state.copyWith(
          isRequestsLoading: false,
          errorMessage: failure.errMessage,
        ),
      ),
      (requests) => emit(
        state.copyWith(isRequestsLoading: false, rentalRequests: requests),
      ),
    );
  }
}
