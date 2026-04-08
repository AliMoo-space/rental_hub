class ResponseParser {
  const ResponseParser._();

  static Map<String, dynamic> extractDataPayload(dynamic raw) {
    if (raw is! Map<String, dynamic>) {
      return {};
    }

    final nestedData = raw['data'];
    if (nestedData is Map<String, dynamic>) {
      return Map<String, dynamic>.from(nestedData);
    }

    return Map<String, dynamic>.from(raw);
  }

  static Map<String, dynamic> extractMessagePayload(
    dynamic raw, {
    String defaultMessage = 'Success',
  }) {
    if (raw is Map<String, dynamic>) {
      final nestedData = raw['data'];

      final dynamic messageCandidate =
          raw['message'] ??
          raw['title'] ??
          raw['detail'] ??
          (nestedData is Map<String, dynamic>
              ? nestedData['message'] ?? nestedData['title']
              : null);

      final message = (messageCandidate ?? '').toString().trim();
      return {'message': message.isEmpty ? defaultMessage : message};
    }

    return {'message': defaultMessage};
  }
}
