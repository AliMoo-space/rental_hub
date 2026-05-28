import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_requests_page_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class GetWithdrawRequestsUseCase {
  final WalletRepo walletRepo;

  GetWithdrawRequestsUseCase(this.walletRepo);

  Future<Either<Failure, WithdrawRequestsPageEntity>> call() {
    return walletRepo.getWithdrawRequests();
  }
}
