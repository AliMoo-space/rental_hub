import 'package:equatable/equatable.dart';

class WalletTransactionEntity extends Equatable {
  final int id;
  final double amount;
  final String type;
  final String description;
  final DateTime createdAt;

  const WalletTransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  @override
  List<Object> get props => [id, amount, type, description, createdAt];
}
