import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  static const String _imageBaseUrl = 'http://rentalplatform.runasp.net';

  const UserProfileModel({
    super.fullName,
    super.phoneNumber,
    super.city,
    super.governorate,
    super.country,
    super.sex,
    super.profileImage,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      fullName: (json['fullName'] ?? json['full_name'] ?? '').toString(),
      phoneNumber: ValidationUtils.normalizeDigits(
        (json['phoneNumber'] ?? json['phone_number'] ?? '').toString(),
      ),
      city: (json['city'] ?? '').toString(),
      governorate: (json['governorate'] ?? json['governorateName'] ?? '')
          .toString(),
      country: (json['country'] ?? '').toString(),
      sex: _normalizeSex((json['sex'] ?? '').toString()),
      profileImage: _normalizeImageUrl(
        (json['profileImage'] ??
                json['profileImageUrl'] ??
                json['imageUrl'] ??
                '')
            .toString(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'city': city,
      'governorate': governorate,
      'country': country,
      'sex': sex,
      'profileImage': profileImage,
    };
  }

  UserProfileEntity toEntity() {
    return UserProfileEntity(
      fullName: fullName,
      phoneNumber: phoneNumber,
      city: city,
      governorate: governorate,
      country: country,
      sex: sex,
      profileImage: profileImage,
    );
  }

  static String _normalizeSex(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.contains('male') || normalized.contains('ذكر')) {
      return 'ذكر';
    }
    if (normalized.contains('female') || normalized.contains('أنثى')) {
      return 'أنثى';
    }
    return value.trim();
  }

  static String _normalizeImageUrl(String value) {
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
