import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/profile/data/models/user_profile_model.dart';

abstract class UserProfileRemoteDataSource {
  Future<UserProfileModel> getProfile();

  Future<bool> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String city,
    required String governorate,
    required String country,
    required String sex,
  });

  Future<String> uploadProfileImage({
    required Uint8List imageBytes,
    required String fileName,
  });

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  });
}

class UserProfileRemoteDataSourceImpl implements UserProfileRemoteDataSource {
  final ApiConsumer apiConsumer;
  static const String _imageBaseUrl = 'http://rentalplatform.runasp.net';

  UserProfileRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<UserProfileModel> getProfile() async {
    final response = await apiConsumer.get(EndPoints.userProfileEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);
    return UserProfileModel.fromJson(payload);
  }

  @override
  Future<bool> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String city,
    required String governorate,
    required String country,
    required String sex,
  }) async {
    final response = await apiConsumer.put(
      EndPoints.userProfileEndpoint,
      data: {
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'city': city,
        'governorate': governorate,
        'country': country,
        'sex': sex,
      },
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    final success = payload['success'];
    if (success is bool) {
      return success;
    }

    if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300) {
      return true;
    }

    throw ServerException(
      ErrorModel(
        statusCode: response.statusCode ?? 500,
        message: 'Unable to update profile',
        errors: {},
      ),
    );
  }

  @override
  Future<String> uploadProfileImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    final response = await apiConsumer.post(
      EndPoints.userProfileUploadImageEndpoint,
      data: {'file': MultipartFile.fromBytes(imageBytes, filename: fileName)},
      isFormData: true,
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    final imageUrl =
        (payload['imageUrl'] ?? payload['profileImage'] ?? payload['url'] ?? '')
            .toString();

    if (imageUrl.trim().isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: response.statusCode ?? 500,
          message: 'Image upload succeeded but the response is invalid',
          errors: {},
        ),
      );
    }

    return _normalizeImageUrl(imageUrl);
  }

  @override
  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    final response = await apiConsumer.put(
      EndPoints.userProfileChangePasswordEndpoint,
      data: {
        'currentPassword': currentPassword,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      },
    );

    final payload = ResponseParser.extractDataPayload(response.data);
    final success = payload['success'];
    if (success is bool) {
      return success;
    }

    if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 300) {
      return true;
    }

    throw ServerException(
      ErrorModel(
        statusCode: response.statusCode ?? 500,
        message: 'Unable to change password',
        errors: {},
      ),
    );
  }

  String _normalizeImageUrl(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '';
    }

    final uri = Uri.tryParse(trimmed);
    if (uri != null && uri.hasScheme) {
      return trimmed;
    }

    if (trimmed.startsWith('/')) {
      return '$_imageBaseUrl$trimmed';
    }

    return '$_imageBaseUrl/$trimmed';
  }
}
