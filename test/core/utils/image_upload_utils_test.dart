import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_hub/core/utils/image_upload_utils.dart';

void main() {
  group('ImageUploadUtils', () {
    test('bytesToMb converts bytes to megabytes', () {
      expect(ImageUploadUtils.bytesToMb(1024 * 1024), closeTo(1.0, 0.001));
      expect(ImageUploadUtils.bytesToMb(5 * 1024 * 1024), closeTo(5.0, 0.001));
    });

    test('uploadSendTimeout is at least two minutes', () {
      expect(
        ImageUploadUtils.uploadSendTimeout.inSeconds,
        greaterThanOrEqualTo(120),
      );
    });

    test('compressionQuality is within requested range', () {
      expect(ImageUploadUtils.compressionQuality, inInclusiveRange(60, 70));
    });

    test('dioMultipartOptions uses multipart content type and upload timeouts', () {
      final options = ImageUploadUtils.dioMultipartOptions(skipAuth: false);

      expect(options.contentType, Headers.multipartFormDataContentType);
      expect(options.sendTimeout, ImageUploadUtils.uploadSendTimeout);
      expect(options.receiveTimeout, ImageUploadUtils.uploadSendTimeout);
      expect(options.headers?[Headers.contentTypeHeader], isNull);
      expect(options.extra?['skipAuth'], isFalse);
    });
  });
}
