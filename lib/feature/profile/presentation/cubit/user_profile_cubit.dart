import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/domain/usecases/change_password_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/get_profile_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/update_profile_usecase.dart';
import 'package:rental_hub/feature/profile/domain/usecases/upload_image_usecase.dart';

import 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadImageUseCase uploadImageUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  UserProfileCubit(
    this.getProfileUseCase,
    this.updateProfileUseCase,
    this.uploadImageUseCase,
    this.changePasswordUseCase,
  ) : super(const UserProfileInitial());

  Future<void> loadProfile() async {
    emit(UserProfileLoading(userProfile: state.userProfile));

    final result = await getProfileUseCase();
    result.fold(
      (failure) => emit(
        UserProfileError(
          message: failure.errMessage,
          userProfile: state.userProfile,
        ),
      ),
      (profile) => emit(UserProfileLoaded(userProfile: profile)),
    );
  }

  Future<void> updateProfile({
    required String fullName,
    required String phoneNumber,
    required String city,
    required String governorate,
    required String country,
    required String sex,
  }) async {
    if (state is UserProfileUpdating) return;

    final currentProfile = state.userProfile ?? const UserProfileEntity();
    emit(UserProfileUpdating(userProfile: currentProfile));

    final result = await updateProfileUseCase(
      fullName: fullName,
      phoneNumber: ValidationUtils.normalizeDigits(phoneNumber),
      city: city,
      governorate: governorate,
      country: country,
      sex: sex,
    );

    result.fold(
      (failure) => emit(
        UserProfileError(
          message: failure.errMessage,
          userProfile: currentProfile,
        ),
      ),
      (success) {
        if (!success) {
          emit(
            UserProfileError(
              message: 'Failed to save changes',
              userProfile: currentProfile,
            ),
          );
          return;
        }

        final updatedProfile = currentProfile.copyWith(
          fullName: fullName,
          phoneNumber: ValidationUtils.normalizeDigits(phoneNumber),
          city: city,
          governorate: governorate,
          country: country,
          sex: sex,
        );

        emit(UserProfileUpdateSuccess(userProfile: updatedProfile));
      },
    );
  }

  Future<void> uploadProfileImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    if (state is ImageUploading) return;

    final currentProfile = state.userProfile ?? const UserProfileEntity();
    emit(ImageUploading(userProfile: currentProfile));

    final result = await uploadImageUseCase(
      imageBytes: imageBytes,
      fileName: fileName,
    );

    result.fold(
      (failure) => emit(
        UserProfileError(
          message: failure.errMessage,
          userProfile: currentProfile,
        ),
      ),
      (imageUrl) {
        emit(
          ImageUploadSuccess(
            userProfile: currentProfile.copyWith(profileImage: imageUrl),
            imageUrl: imageUrl,
          ),
        );
      },
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmNewPassword,
  }) async {
    if (state is PasswordChanging) return;

    final currentProfile = state.userProfile ?? const UserProfileEntity();
    emit(PasswordChanging(userProfile: currentProfile));

    final result = await changePasswordUseCase(
      currentPassword: currentPassword,
      newPassword: newPassword,
      confirmNewPassword: confirmNewPassword,
    );

    result.fold(
      (failure) => emit(
        UserProfileError(
          message: failure.errMessage,
          userProfile: currentProfile,
        ),
      ),
      (success) {
        if (!success) {
          emit(
            UserProfileError(
              message: 'Failed to change password',
              userProfile: currentProfile,
            ),
          );
          return;
        }

        emit(PasswordChangeSuccess(userProfile: currentProfile));
      },
    );
  }
}
