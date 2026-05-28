import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_action_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_balance_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transaction_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_request_entity.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/deposit_wallet_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_wallet_balance_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_wallet_transactions_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/get_withdraw_requests_use_case.dart';
import 'package:rental_hub/feature/wallet/domain/usecases/request_wallet_withdraw_use_case.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWalletBalanceUseCase getWalletBalanceUseCase;
  final GetWalletTransactionsUseCase getWalletTransactionsUseCase;
  final DepositWalletUseCase depositWalletUseCase;
  final RequestWalletWithdrawUseCase requestWalletWithdrawUseCase;
  final GetWithdrawRequestsUseCase getWithdrawRequestsUseCase;

  WalletCubit(
    this.getWalletBalanceUseCase,
    this.getWalletTransactionsUseCase,
    this.depositWalletUseCase,
    this.requestWalletWithdrawUseCase,
    this.getWithdrawRequestsUseCase,
  ) : super(const WalletState());

  Future<void> loadWallet({
    bool showLoading = true,
    bool suppressErrors = false,
  }) async {
    if (state.isLoading) return;

    if (showLoading) {
      emit(state.copyWith(isLoading: true, errorMessage: null));
    }

    String? failureMessage;
    WalletBalanceEntity? balance;
    List<WalletTransactionEntity> transactions = state.transactions;
    List<WithdrawRequestEntity> withdrawRequests = state.withdrawRequests;

    final balanceFuture = getWalletBalanceUseCase();
    final transactionsFuture = getWalletTransactionsUseCase();
    final withdrawRequestsFuture = getWithdrawRequestsUseCase();

    final balanceResult = await balanceFuture;
    balanceResult.fold(
      (failure) => failureMessage ??= failure.errMessage,
      (value) => balance = value,
    );

    final transactionsResult = await transactionsFuture;
    transactionsResult.fold(
      (failure) => failureMessage ??= failure.errMessage,
      (value) => transactions = value.items,
    );

    final withdrawRequestsResult = await withdrawRequestsFuture;
    withdrawRequestsResult.fold(
      (failure) => failureMessage ??= failure.errMessage,
      (value) => withdrawRequests = value.items,
    );

    emit(
      state.copyWith(
        isLoading: false,
        balance: balance ?? state.balance,
        transactions: transactions,
        withdrawRequests: withdrawRequests,
        errorMessage: suppressErrors ? state.errorMessage : failureMessage,
      ),
    );
  }

  Future<void> deposit({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  }) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await depositWalletUseCase(
      amount: amount,
      method: method,
      phoneNumber: phoneNumber,
      cardToken: cardToken,
    );

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
      },
      (WalletDepositResultEntity value) async {
        await loadWallet(showLoading: false, suppressErrors: true);
        emit(
          state.copyWith(
            isSubmitting: false,
            balance: WalletBalanceEntity(
              balance: value.newBalance,
              currency: state.balance?.currency ?? 'EGP',
            ),
            actionMessage: value.message,
          ),
        );
      },
    );
  }

  Future<void> requestWithdraw({
    required double amount,
    required String phoneNumber,
  }) async {
    if (state.isSubmitting) return;

    emit(
      state.copyWith(
        isSubmitting: true,
        errorMessage: null,
        actionMessage: null,
      ),
    );

    final result = await requestWalletWithdrawUseCase(
      amount: amount,
      phoneNumber: phoneNumber,
    );

    await result.fold(
      (failure) async {
        emit(
          state.copyWith(isSubmitting: false, errorMessage: failure.errMessage),
        );
      },
      (WalletActionResultEntity value) async {
        await loadWallet(showLoading: false, suppressErrors: true);
        emit(state.copyWith(isSubmitting: false, actionMessage: value.message));
      },
    );
  }

  void clearFeedback() {
    emit(state.copyWith(errorMessage: null, actionMessage: null));
  }
}
