import 'package:equatable/equatable.dart';

class WalletDepositResultEntity extends Equatable {
  final String message;
  final double newBalance;

  const WalletDepositResultEntity({
    required this.message,
    required this.newBalance,
  });

  @override
  List<Object> get props => [message, newBalance];
}
