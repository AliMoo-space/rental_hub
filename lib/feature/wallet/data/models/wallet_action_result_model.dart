import 'package:rental_hub/feature/wallet/domain/entities/wallet_action_result_entity.dart';

class WalletActionResultModel extends WalletActionResultEntity {
  const WalletActionResultModel({required super.message});

  factory WalletActionResultModel.fromJson(Map<String, dynamic> json) {
    return WalletActionResultModel(
      message: json['message']?.toString() ?? 'Success',
    );
  }
}
