import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class DepositWalletUseCase {
  final WalletRepo walletRepo;

  DepositWalletUseCase(this.walletRepo);

  Future<Either<Failure, WalletDepositResultEntity>> call({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  }) {
    return walletRepo.deposit(
      amount: amount,
      method: method,
      phoneNumber: phoneNumber,
      cardToken: cardToken,
    );
  }
}
