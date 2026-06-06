class ResponseParser {
  const ResponseParser._();

  static Map<String, dynamic> extractDataPayload(dynamic raw) {
    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      final nestedData = map['data'];

      if (nestedData is Map) {
        return Map<String, dynamic>.from(nestedData);
      }

      if (nestedData is List) {
        return {'items': List<dynamic>.from(nestedData)};
      }

      return map;
    }

    if (raw is List) {
      return {'items': List<dynamic>.from(raw)};
    }

    return <String, dynamic>{};
  }

  static Map<String, dynamic> extractMessagePayload(
    dynamic raw, {
    String defaultMessage = 'Success',
  }) {
    if (raw is Map) {
      final map = Map<String, dynamic>.from(raw);
      final nestedData = map['data'];

      final dynamic messageCandidate =
          map['message'] ??
          map['title'] ??
          map['detail'] ??
          (nestedData is Map
              ? (Map<String, dynamic>.from(nestedData))['message'] ??
                  (Map<String, dynamic>.from(nestedData))['title']
              : null);

      final message = (messageCandidate ?? '').toString().trim();
      return {'message': message.isEmpty ? defaultMessage : message};
    }

    return {'message': defaultMessage};
  }
}
