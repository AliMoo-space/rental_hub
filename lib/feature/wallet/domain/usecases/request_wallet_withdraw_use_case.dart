import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_action_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class RequestWalletWithdrawUseCase {
  final WalletRepo walletRepo;

  RequestWalletWithdrawUseCase(this.walletRepo);

  Future<Either<Failure, WalletActionResultEntity>> call({
    required double amount,
    required String phoneNumber,
  }) {
    return walletRepo.requestWithdraw(amount: amount, phoneNumber: phoneNumber);
  }
}
