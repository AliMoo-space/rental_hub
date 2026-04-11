class ValidationUtils {
  static const int otpLength = 6;

  static final RegExp _emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
  static final RegExp _digitsOnlyRegex = RegExp(r'^\d+$');

  static String normalizeOtp(String value) => value.trim();

  static bool isValidEmail(String email) {
    return _emailRegex.hasMatch(email.trim());
  }

  static bool hasOnlyDigits(String value) {
    return _digitsOnlyRegex.hasMatch(value.trim());
  }
}
