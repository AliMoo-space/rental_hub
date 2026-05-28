import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/wallet/data/datasource/wallet_remote_data_source.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_action_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_balance_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_result_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_transactions_page_entity.dart';
import 'package:rental_hub/feature/wallet/domain/entities/withdraw_requests_page_entity.dart';
import 'package:rental_hub/feature/wallet/domain/repo/wallet_repo.dart';

class WalletRepoImpl implements WalletRepo {
  final WalletRemoteDataSource remoteDataSource;

  WalletRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, WalletBalanceEntity>> getBalance() async {
    try {
      final response = await remoteDataSource.getBalance();
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to fetch wallet balance: $e'));
    }
  }

  @override
  Future<Either<Failure, WalletTransactionsPageEntity>>
  getTransactions() async {
    try {
      final response = await remoteDataSource.getTransactions();
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(
        Failure(errMessage: 'Failed to fetch wallet transactions: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, WalletDepositResultEntity>> deposit({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  }) async {
    try {
      final response = await remoteDataSource.deposit(
        amount: amount,
        method: method,
        phoneNumber: phoneNumber,
        cardToken: cardToken,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to deposit wallet balance: $e'));
    }
  }

  @override
  Future<Either<Failure, WalletActionResultEntity>> requestWithdraw({
    required double amount,
    required String phoneNumber,
  }) async {
    try {
      final response = await remoteDataSource.requestWithdraw(
        amount: amount,
        phoneNumber: phoneNumber,
      );
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to submit withdraw request: $e'));
    }
  }

  @override
  Future<Either<Failure, WithdrawRequestsPageEntity>>
  getWithdrawRequests() async {
    try {
      final response = await remoteDataSource.getWithdrawRequests();
      return Right(response);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to fetch withdraw requests: $e'));
    }
  }
}
