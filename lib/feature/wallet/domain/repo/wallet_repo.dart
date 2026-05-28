import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_action_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_balance_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transactions_page_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_requests_page_entity.dart';

abstract class WalletRepo {
  Future<Either<Failure, WalletBalanceEntity>> getBalance();
  Future<Either<Failure, WalletTransactionsPageEntity>> getTransactions();
  Future<Either<Failure, WalletDepositResultEntity>> deposit({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  });
  Future<Either<Failure, WalletActionResultEntity>> requestWithdraw({
    required double amount,
    required String phoneNumber,
  });
  Future<Either<Failure, WithdrawRequestsPageEntity>> getWithdrawRequests();
}
