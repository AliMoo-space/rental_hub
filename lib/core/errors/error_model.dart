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
        extractedErrors[key] = List<String>.from(value);
      });
    }

    return ErrorModel(
      statusCode: json['statusCode'] ?? 0,
      message: json['message'] ?? '',
      errors: extractedErrors,
    );
  }

  /// أول رسالة مهما كان المفتاح
  String get firstErrorMessage {
    if (errors.isEmpty) return message;
    return errors.values.first.first;
  }
}
