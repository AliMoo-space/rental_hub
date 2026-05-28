import 'package:rental_hub/feature/wallet/domain/entities/wallet_deposit_result_entity.dart';

class WalletDepositResultModel extends WalletDepositResultEntity {
  const WalletDepositResultModel({
    required super.message,
    required super.newBalance,
  });

  factory WalletDepositResultModel.fromJson(Map<String, dynamic> json) {
    return WalletDepositResultModel(
      message: json['message']?.toString() ?? 'Success',
      newBalance: _parseDouble(json['newBalance']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }
}
