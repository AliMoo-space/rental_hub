import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';

abstract class UserProfileState extends Equatable {
  final UserProfileEntity? userProfile;
  final String? message;
  final String? imageUrl;

  const UserProfileState({this.userProfile, this.message, this.imageUrl});

  @override
  List<Object?> get props => [userProfile, message, imageUrl];
}

class UserProfileInitial extends UserProfileState {
  const UserProfileInitial();
}

class UserProfileLoading extends UserProfileState {
  const UserProfileLoading({super.userProfile});
}

class UserProfileLoaded extends UserProfileState {
  const UserProfileLoaded({required super.userProfile});
}

class UserProfileUpdating extends UserProfileState {
  const UserProfileUpdating({super.userProfile});
}

class UserProfileUpdateSuccess extends UserProfileState {
  const UserProfileUpdateSuccess({required super.userProfile, super.message});
}

class ImageUploading extends UserProfileState {
  const ImageUploading({super.userProfile});
}

class ImageUploadSuccess extends UserProfileState {
  const ImageUploadSuccess({
    required super.userProfile,
    required super.imageUrl,
    super.message,
  });
}

class PasswordChanging extends UserProfileState {
  const PasswordChanging({super.userProfile});
}

class PasswordChangeSuccess extends UserProfileState {
  const PasswordChangeSuccess({super.userProfile, super.message});
}

class UserProfileError extends UserProfileState {
  const UserProfileError({required super.message, super.userProfile});
}
