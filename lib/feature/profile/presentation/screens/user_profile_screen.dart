import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/utils/validation_utils.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/feature/profile/domain/entities/user_profile_entity.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_cubit.dart';
import 'package:rental_hub/feature/profile/presentation/cubit/user_profile_state.dart';
// Removed unused app_drawer import (not used in this screen)
import 'package:rental_hub/feature/profile/presentation/widgets/change_password_form.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/location_form.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/personal_info_form.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/profile_image_picker.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  static const Color profilePrimaryColor = Color(0xFF6C63FF);

  @override
  Widget build(BuildContext context) {
    return const _UserProfileView();
  }
}

class _UserProfileView extends StatefulWidget {
  const _UserProfileView();

  @override
  State<_UserProfileView> createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<_UserProfileView> {
  final GlobalKey<FormState> _profileFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _passwordFormKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  Uint8List? _localImageBytes;
  String _selectedSex = 'ذكر';

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    _countryController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  void _applyProfileToControllers(UserProfileEntity profile) {
    _fullNameController.text = profile.fullName;
    _phoneNumberController.text = ValidationUtils.normalizeDigits(
      profile.phoneNumber,
    );
    _cityController.text = profile.city;
    _governorateController.text = profile.governorate;
    _countryController.text = profile.country;
    _selectedSex = _normalizeSex(profile.sex);
    _localImageBytes = null;
  }

  void _clearPasswordFields() {
    _currentPasswordController.clear();
    _newPasswordController.clear();
    _confirmNewPasswordController.clear();
  }

  String _normalizeSex(String value) {
    final normalized = value.trim().toLowerCase();
    if (normalized.contains('female') || normalized.contains('أنثى')) {
      return 'أنثى';
    }
    return 'ذكر';
  }

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final userProfileCubit = context.read<UserProfileCubit>();
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedImage == null) {
      return;
    }

    final imageBytes = await pickedImage.readAsBytes();
    if (!mounted) {
      return;
    }

    setState(() {
      _localImageBytes = imageBytes;
    });

    await userProfileCubit.uploadProfileImage(
      imageBytes: imageBytes,
      fileName: pickedImage.name.isNotEmpty ? pickedImage.name : 'profile.jpg',
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
      listener: (context, state) {
        if (state is UserProfileLoaded) {
          setState(() {
            _applyProfileToControllers(
              state.userProfile ?? const UserProfileEntity(),
            );
          });
        } else if (state is UserProfileUpdateSuccess) {
          setState(() {
            _applyProfileToControllers(
              state.userProfile ?? const UserProfileEntity(),
            );
          });
          showMsg(state.message, context);
        } else if (state is ImageUploadSuccess) {
          setState(() {
            _applyProfileToControllers(
              state.userProfile ?? const UserProfileEntity(),
            );
          });
          showMsg(state.message, context);
        } else if (state is PasswordChangeSuccess) {
          _clearPasswordFields();
          showMsg(state.message, context);
        } else if (state is UserProfileError) {
          if (_localImageBytes != null) {
            setState(() {
              _localImageBytes = null;
            });
          }
          showMsg(state.message, context, isError: true);
        }
      },
      builder: (context, state) {
        final profile = state.userProfile ?? const UserProfileEntity();
        final isProfileLoading =
            state is UserProfileLoading &&
            profile.fullName.isEmpty &&
            profile.phoneNumber.isEmpty &&
            profile.city.isEmpty &&
            profile.governorate.isEmpty &&
            profile.country.isEmpty;
        final isProfileUpdating = state is UserProfileUpdating;
        final isImageUploading = state is ImageUploading;
        final isPasswordChanging = state is PasswordChanging;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            surfaceTintColor: Colors.white,
            title: Text('تعديل الملف الشخصي', style: AppStyles.titleMedium),
          ),
          bottomNavigationBar: SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: AppColors.borderColor)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 18,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: PrimaryButtonWidget(
                buttonText: 'حفظ التغييرات',
                onPress: () {
                  if (_profileFormKey.currentState?.validate() != true) {
                    return;
                  }

                  context.read<UserProfileCubit>().updateProfile(
                    fullName: _fullNameController.text.trim(),
                    phoneNumber: _phoneNumberController.text.trim(),
                    city: _cityController.text.trim(),
                    governorate: _governorateController.text.trim(),
                    country: _countryController.text.trim(),
                    sex: _selectedSex,
                  );
                },
                buttonColor: UserProfileScreen.profilePrimaryColor,
                isLoading: isProfileUpdating,
                width: double.infinity,
                height: 56.h,
              ),
            ),
          ),
          body: isProfileLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: UserProfileScreen.profilePrimaryColor,
                  ),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 24.h),
                  child: Column(
                    children: [
                      ProfileImagePicker(
                        imageUrl: profile.profileImage,
                        localImageBytes: _localImageBytes,
                        isUploading: isImageUploading,
                        onEditPressed: () => _pickAndUploadImage(context),
                      ),
                      SizedBox(height: 24.h),
                      Form(
                        key: _profileFormKey,
                        child: Column(
                          children: [
                            _ProfileSectionCard(
                              icon: Icons.person_outline_rounded,
                              title: 'البيانات الشخصية',
                              child: PersonalInfoForm(
                                fullNameController: _fullNameController,
                                phoneNumberController: _phoneNumberController,
                                sex: _selectedSex,
                                onSexChanged: (value) {
                                  if (value == null || value.isEmpty) {
                                    return;
                                  }
                                  setState(() {
                                    _selectedSex = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 16.h),
                            _ProfileSectionCard(
                              icon: Icons.location_on_outlined,
                              title: 'الموقع',
                              child: LocationForm(
                                cityController: _cityController,
                                governorateController: _governorateController,
                                countryController: _countryController,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _ProfileSectionCard(
                        icon: Icons.lock_outline_rounded,
                        title: 'تغيير كلمة المرور',
                        child: ChangePasswordForm(
                          formKey: _passwordFormKey,
                          currentPasswordController: _currentPasswordController,
                          newPasswordController: _newPasswordController,
                          confirmNewPasswordController:
                              _confirmNewPasswordController,
                          isLoading: isPasswordChanging,
                          onSubmit: () {
                            if (_passwordFormKey.currentState?.validate() !=
                                true) {
                              return;
                            }

                            context.read<UserProfileCubit>().changePassword(
                              currentPassword: _currentPasswordController.text
                                  .trim(),
                              newPassword: _newPasswordController.text.trim(),
                              confirmNewPassword: _confirmNewPasswordController
                                  .text
                                  .trim(),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 96.h),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _ProfileSectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;

  const _ProfileSectionCard({
    required this.icon,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: const BoxDecoration(
                  color: Color(0xFFF0EEFF),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: UserProfileScreen.profilePrimaryColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(title, style: AppStyles.titleMedium),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }
}
