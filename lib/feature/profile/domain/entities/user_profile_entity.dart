import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  final String fullName;
  final String phoneNumber;
  final String city;
  final String governorate;
  final String country;
  final String sex;
  final String profileImage;

  const UserProfileEntity({
    this.fullName = '',
    this.phoneNumber = '',
    this.city = '',
    this.governorate = '',
    this.country = '',
    this.sex = '',
    this.profileImage = '',
  });

  UserProfileEntity copyWith({
    String? fullName,
    String? phoneNumber,
    String? city,
    String? governorate,
    String? country,
    String? sex,
    String? profileImage,
  }) {
    return UserProfileEntity(
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      governorate: governorate ?? this.governorate,
      country: country ?? this.country,
      sex: sex ?? this.sex,
      profileImage: profileImage ?? this.profileImage,
    );
  }

  @override
  List<Object> get props => [
    fullName,
    phoneNumber,
    city,
    governorate,
    country,
    sex,
    profileImage,
  ];
}
