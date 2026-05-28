import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/wallet/data/models/wallet_action_result_model.dart';
import 'package:rental_hub/feature/wallet/data/models/wallet_balance_model.dart';
import 'package:rental_hub/feature/wallet/data/models/wallet_deposit_result_model.dart';
import 'package:rental_hub/feature/wallet/data/models/wallet_transactions_page_model.dart';
import 'package:rental_hub/feature/wallet/data/models/withdraw_requests_page_model.dart';
import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_method.dart';

abstract class WalletRemoteDataSource {
  Future<WalletBalanceModel> getBalance();
  Future<WalletTransactionsPageModel> getTransactions();
  Future<WalletDepositResultModel> deposit({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  });
  Future<WalletActionResultModel> requestWithdraw({
    required double amount,
    required String phoneNumber,
  });
  Future<WithdrawRequestsPageModel> getWithdrawRequests();
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final ApiConsumer apiConsumer;

  WalletRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<WalletBalanceModel> getBalance() async {
    final response = await apiConsumer.get(EndPoints.walletBalanceEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);
    return WalletBalanceModel.fromJson(payload);
  }

  @override
  Future<WalletTransactionsPageModel> getTransactions() async {
    final response = await apiConsumer.get(
      EndPoints.walletTransactionsEndpoint,
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return WalletTransactionsPageModel.fromJson(payload);
  }

  @override
  Future<WalletDepositResultModel> deposit({
    required double amount,
    required WalletDepositMethod method,
    String? phoneNumber,
    String? cardToken,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.walletDepositEndpoint,
      data: {
        'amount': amount,
        'method': method.apiValue,
        'phoneNumber': phoneNumber ?? '',
        'cardToken': cardToken ?? '',
      },
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return WalletDepositResultModel.fromJson(payload);
  }

  @override
  Future<WalletActionResultModel> requestWithdraw({
    required double amount,
    required String phoneNumber,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.walletWithdrawRequestEndpoint,
      data: {'amount': amount, 'phoneNumber': phoneNumber},
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return WalletActionResultModel.fromJson(payload);
  }

  @override
  Future<WithdrawRequestsPageModel> getWithdrawRequests() async {
    final response = await apiConsumer.get(
      EndPoints.walletWithdrawRequestsEndpoint,
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    return WithdrawRequestsPageModel.fromJson(payload);
  }
}
