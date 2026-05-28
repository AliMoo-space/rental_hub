import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_balance_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class GetWalletBalanceUseCase {
  final WalletRepo walletRepo;

  GetWalletBalanceUseCase(this.walletRepo);

  Future<Either<Failure, WalletBalanceEntity>> call() {
    return walletRepo.getBalance();
  }
}
