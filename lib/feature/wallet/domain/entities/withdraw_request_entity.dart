import 'package:equatable/equatable.dart';

class WithdrawRequestEntity extends Equatable {
  final int id;
  final String userId;
  final String userName;
  final double amount;
  final String phoneNumber;
  final String status;
  final String? rejectionReason;
  final DateTime createdAt;
  final DateTime? processedAt;

  const WithdrawRequestEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.amount,
    required this.phoneNumber,
    required this.status,
    required this.rejectionReason,
    required this.createdAt,
    required this.processedAt,
  });

  @override
  List<Object?> get props => [
    id,
    userId,
    userName,
    amount,
    phoneNumber,
    status,
    rejectionReason,
    createdAt,
    processedAt,
  ];
}
