import 'dart:developer' as developer;
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

/// Utilities for compressing and logging image payloads before multipart upload.
class ImageUploadUtils {
  ImageUploadUtils._();

  static const int compressionQuality = 65;
  static const Duration uploadSendTimeout = Duration(minutes: 2);

  static double bytesToMb(int bytes) => bytes / (1024 * 1024);

  /// Logs image count and per-file size (MB) before FormData is built.
  static Future<void> logImagesBeforeUpload(
    List<XFile> images, {
    String logTag = 'ProductUpload',
  }) async {
    developer.log(
      '[$logTag] Image count before upload: ${images.length}',
      name: logTag,
    );

    for (var i = 0; i < images.length; i++) {
      final file = File(images[i].path);
      final bytes = await file.length();
      developer.log(
        '[$logTag] Image ${i + 1}/${images.length} size before compression: '
        '${bytesToMb(bytes).toStringAsFixed(2)} MB (${images[i].name})',
        name: logTag,
      );
    }
  }

  /// Compresses all [images] and converts them to [MultipartFile]s.
  static Future<List<MultipartFile>> compressImagesToMultipartFiles(
    List<XFile> images, {
    String logTag = 'ProductUpload',
  }) async {
    final multipartFiles = <MultipartFile>[];
    var totalBeforeBytes = 0;
    var totalAfterBytes = 0;

    for (var i = 0; i < images.length; i++) {
      final image = images[i];
      final file = File(image.path);
      final beforeBytes = await file.length();
      totalBeforeBytes += beforeBytes;

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        image.path,
        quality: compressionQuality,
        format: CompressFormat.jpeg,
      );

      final filename = _jpegFilename(image.name);

      if (compressedBytes != null && compressedBytes.isNotEmpty) {
        final afterBytes = compressedBytes.length;
        totalAfterBytes += afterBytes;

        developer.log(
          '[$logTag] Image ${i + 1}/${images.length} size after compression: '
          '${bytesToMb(afterBytes).toStringAsFixed(2)} MB',
          name: logTag,
        );

        multipartFiles.add(
          MultipartFile.fromBytes(compressedBytes, filename: filename),
        );
      } else {
        developer.log(
          '[$logTag] Compression failed for image ${i + 1}/${images.length}, '
          'using original file (${bytesToMb(beforeBytes).toStringAsFixed(2)} MB)',
          name: logTag,
        );
        totalAfterBytes += beforeBytes;
        multipartFiles.add(
          await MultipartFile.fromFile(image.path, filename: image.name),
        );
      }
    }

    developer.log(
      '[$logTag] Compression summary: count=${images.length}, '
      'total before=${bytesToMb(totalBeforeBytes).toStringAsFixed(2)} MB, '
      'total after=${bytesToMb(totalAfterBytes).toStringAsFixed(2)} MB',
      name: logTag,
    );

    return multipartFiles;
  }

  /// Logs the estimated multipart payload size after [FormData] is assembled.
  static Future<void> logFormDataPayload(
    FormData formData, {
    String logTag = 'ProductUpload',
  }) async {
    var fieldsBytes = 0;
    for (final field in formData.fields) {
      fieldsBytes += field.key.length + field.value.length;
    }

    var filesBytes = 0;
    for (final entry in formData.files) {
      final length = entry.value.length;
      if (length >= 0) {
        filesBytes += length;
      }
    }

    final totalBytes = fieldsBytes + filesBytes;
    developer.log(
      '[$logTag] Total upload payload size: '
      '${bytesToMb(totalBytes).toStringAsFixed(2)} MB '
      '(fields=${bytesToMb(fieldsBytes).toStringAsFixed(3)} MB, '
      'files=${bytesToMb(filesBytes).toStringAsFixed(2)} MB, '
      'fileCount=${formData.files.length})',
      name: logTag,
    );
  }

  static String _jpegFilename(String originalName) {
    final dotIndex = originalName.lastIndexOf('.');
    final base = dotIndex > 0
        ? originalName.substring(0, dotIndex)
        : originalName;
    return '$base.jpg';
  }

  /// Dio [Options] for multipart uploads (clears forced JSON content type).
  static Options dioMultipartOptions({required bool skipAuth}) {
    return Options(
      extra: {'skipAuth': skipAuth},
      contentType: Headers.multipartFormDataContentType,
      sendTimeout: uploadSendTimeout,
      receiveTimeout: uploadSendTimeout,
      headers: const {Headers.contentTypeHeader: null},
    );
  }
}
