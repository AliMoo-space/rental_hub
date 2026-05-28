class ValidationUtils {
  static const int otpLength = 6;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _digitsOnlyRegex = RegExp(r'^\d+$');

  static String normalizeOtp(String value) => value.trim();

  static String normalizeDigits(String value) {
    return value.replaceAll(RegExp(r'\D'), '');
  }

  static final RegExp _passwordUppercaseRegex = RegExp(r'[A-Z]');
  static final RegExp _passwordNumberRegex = RegExp(r'\d');
  static final RegExp _passwordSpecialCharRegex = RegExp(
    r'[!@#\$%^&*(),.?":{}|<>_\-\\/\[\];~+=]',
  );

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  static bool hasOnlyDigits(String value) {
    return _digitsOnlyRegex.hasMatch(value.trim());
  }

  static bool isValidFullName(String value) {
    return value.trim().length >= 3;
  }

  static bool isValidPhoneNumber(String value) {
    final normalized = normalizeDigits(value);
    return normalized.length >= 11 && hasOnlyDigits(normalized);
  }

  static bool isValidPassword(String value) {
    final trimmed = value.trim();
    return trimmed.length >= 8 &&
        _passwordUppercaseRegex.hasMatch(trimmed) &&
        _passwordNumberRegex.hasMatch(trimmed) &&
        _passwordSpecialCharRegex.hasMatch(trimmed);
  }
}
