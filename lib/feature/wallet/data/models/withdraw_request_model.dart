import 'package:rental_hub/feature/wallet/domain/entities/withdraw_request_entity.dart';

class WithdrawRequestModel extends WithdrawRequestEntity {
  const WithdrawRequestModel({
    required super.id,
    required super.userId,
    required super.userName,
    required super.amount,
    required super.phoneNumber,
    required super.status,
    required super.rejectionReason,
    required super.createdAt,
    required super.processedAt,
  });

  factory WithdrawRequestModel.fromJson(Map<String, dynamic> json) {
    return WithdrawRequestModel(
      id: _parseInt(json['id']),
      userId: json['userId']?.toString() ?? '',
      userName: json['userName']?.toString() ?? '',
      amount: _parseDouble(json['amount']),
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      rejectionReason: json['rejectionReason']?.toString(),
      createdAt: _parseDateTime(json['createdAt']),
      processedAt: _parseNullableDateTime(json['processedAt']),
    );
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _parseDouble(dynamic value) {
    if (value is double) return value;
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    final text = value?.toString();
    if (text == null || text.isEmpty) {
      return DateTime.fromMillisecondsSinceEpoch(0);
    }
    return DateTime.tryParse(text) ?? DateTime.fromMillisecondsSinceEpoch(0);
  }

  static DateTime? _parseNullableDateTime(dynamic value) {
    final text = value?.toString();
    if (text == null || text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}
