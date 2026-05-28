part of 'wallet_cubit.dart';

const Object _walletStateUnset = Object();

class WalletState extends Equatable {
  final WalletBalanceEntity? balance;
  final List<WalletTransactionEntity> transactions;
  final List<WithdrawRequestEntity> withdrawRequests;
  final bool isLoading;
  final bool isSubmitting;
  final String? errorMessage;
  final String? actionMessage;

  const WalletState({
    this.balance,
    this.transactions = const [],
    this.withdrawRequests = const [],
    this.isLoading = false,
    this.isSubmitting = false,
    this.errorMessage,
    this.actionMessage,
  });

  WalletState copyWith({
    WalletBalanceEntity? balance,
    List<WalletTransactionEntity>? transactions,
    List<WithdrawRequestEntity>? withdrawRequests,
    bool? isLoading,
    bool? isSubmitting,
    Object? errorMessage = _walletStateUnset,
    Object? actionMessage = _walletStateUnset,
  }) {
    return WalletState(
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
      withdrawRequests: withdrawRequests ?? this.withdrawRequests,
      isLoading: isLoading ?? this.isLoading,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: identical(errorMessage, _walletStateUnset)
          ? this.errorMessage
          : errorMessage as String?,
      actionMessage: identical(actionMessage, _walletStateUnset)
          ? this.actionMessage
          : actionMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    balance,
    transactions,
    withdrawRequests,
    isLoading,
    isSubmitting,
    errorMessage,
    actionMessage,
  ];
}
