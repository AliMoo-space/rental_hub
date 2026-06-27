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

    final statusCode =
        _parseInt(json['statusCode']) ?? _parseInt(json['status']);
    final message = (json['message'] ?? json['title'] ?? json['detail'] ?? '')
        .toString()
        .trim();

    return ErrorModel(
      statusCode: statusCode ?? 0,
      message: message,
      errors: extractedErrors,
    );
  }

  /// Primary user-facing message: field errors first, then API message, then fallback.
  String get firstErrorMessage {
    if (errors.isNotEmpty) {
      for (final messages in errors.values) {
        for (final entry in messages) {
          final trimmed = entry.trim();
          if (trimmed.isNotEmpty) return trimmed;
        }
      }
    }

    final trimmedMessage = message.trim();
    if (trimmedMessage.isNotEmpty) return trimmedMessage;

    if (statusCode > 0) {
      return 'حدث خطأ أثناء تنفيذ الطلب (رمز: $statusCode)';
    }

    return 'حدث خطأ غير متوقع';
  }

  /// Detailed message for logs, including all validation errors when present.
  String get logMessage {
    if (errors.isEmpty) {
      return 'statusCode=$statusCode message=$message';
    }

    final details = errors.entries
        .map((entry) => '${entry.key}: ${entry.value.join(', ')}')
        .join(' | ');
    return 'statusCode=$statusCode message=$message errors=$details';
  }

  static int? _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }
}
