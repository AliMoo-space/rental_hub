class ErrorModel {
  final int statusCode;
  final String message;
  final Map<String, List<String>> errors;

  ErrorModel({
    required this.statusCode,
    required this.message,
    required this.errors,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<String>> extractedErrors = {};

    if (json['errors'] != null && json['errors'] is Map) {
      (json['errors'] as Map<String, dynamic>).forEach((key, value) {
        if (value is List) {
          extractedErrors[key] = value.map((e) => e.toString()).toList();
          return;
        }
        if (value != null) {
          extractedErrors[key] = [value.toString()];
        }
      });
    }

    final statusCode = _parseInt(json['statusCode']) ?? _parseInt(json['status']);
    final message = (json['message'] ?? json['title'] ?? json['detail'] ?? '')
        .toString()
        .trim();

    return ErrorModel(
      statusCode: statusCode ?? 0,
      message: message,
      errors: extractedErrors,
    );
  }

  /// أول رسالة مهما كان المفتاح
  String get firstErrorMessage {
    if (errors.isEmpty) return message;
    return errors.values.first.first;
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
