import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transactions_page_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class GetWalletTransactionsUseCase {
  final WalletRepo walletRepo;

  GetWalletTransactionsUseCase(this.walletRepo);

  Future<Either<Failure, WalletTransactionsPageEntity>> call() {
    return walletRepo.getTransactions();
  }
}
