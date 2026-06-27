import 'package:flutter_test/flutter_test.dart';
import 'package:rental_hub/core/errors/error_model.dart';

void main() {
  group('ErrorModel', () {
    test('firstErrorMessage returns field validation error when present', () {
      final model = ErrorModel(
        statusCode: 400,
        message: 'One or more validation errors occurred.',
        errors: {
          'Images': ['The Images field is required.'],
        },
      );

      expect(model.firstErrorMessage, 'The Images field is required.');
    });

    test(
      'firstErrorMessage falls back to status code when message is empty',
      () {
        final model = ErrorModel(statusCode: 500, message: '', errors: {});

        expect(model.firstErrorMessage, 'حدث خطأ أثناء تنفيذ الطلب (رمز: 500)');
      },
    );

    test('logMessage includes validation details', () {
      final model = ErrorModel(
        statusCode: 400,
        message: 'Validation failed',
        errors: {
          'Name': ['Name is required'],
        },
      );

      expect(model.logMessage, contains('Name: Name is required'));
      expect(model.logMessage, contains('statusCode=400'));
    });
  });
}
