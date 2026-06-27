import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';

class ProductTransactionModel extends ProductTransactionEntity {
  const ProductTransactionModel({
    required super.id,
    required super.renterName,
    required super.startDate,
    required super.endDate,
    required super.totalPrice,
    required super.status,
  });

  factory ProductTransactionModel.fromJson(Map<String, dynamic> json) {
    return ProductTransactionModel(
      id: _parseInt(json['id'] ?? json['transactionId']),
      renterName:
          json['renterName']?.toString() ??
          json['renterFullName']?.toString() ??
          'مستأجر',
      startDate: _parseDateTime(
        json['startDate'] ?? json['start_date'] ?? json['rentDate'],
      ),
      endDate: _parseDateTime(
        json['endDate'] ?? json['end_date'] ?? json['returnDate'],
      ),
      totalPrice: _parseDouble(
        json['totalPrice'] ?? json['amount'] ?? json['total_price'],
      ),
      status: json['status']?.toString() ?? 'Completed',
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
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  static DateTime _parseDateTime(dynamic value) {
    if (value is DateTime) return value;
    final text = value?.toString();
    if (text == null || text.isEmpty) return DateTime.now();
    return DateTime.parse(text);
  }
}
