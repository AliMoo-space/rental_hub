import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_assets.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/feature/add_listing/data/models/create_product_request.dart';
import 'package:rental_hub/feature/add_listing/presentation/cubit/add_listing_cubit.dart';
import 'package:rental_hub/feature/add_listing/presentation/cubit/add_listing_state.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/condition_toggle_button.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/image_picker_grid.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/labeled_text_field.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/listing_card.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/picker_field.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/price_field.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';

class AddListingScreen extends StatefulWidget {
  const AddListingScreen({super.key});

  @override
  State<AddListingScreen> createState() => _AddListingScreenState();
}

class _AddListingScreenState extends State<AddListingScreen> {
  static const List<_SelectionOption<String>> _cityOptions = [
    _SelectionOption(label: 'القاهرة', value: 'القاهرة'),
    _SelectionOption(label: 'الجيزة', value: 'الجيزة'),
    _SelectionOption(label: 'الإسكندرية', value: 'الإسكندرية'),
  ];

  static const List<_SelectionOption<String>> _governorateOptions = [
    _SelectionOption(label: 'القاهرة', value: 'القاهرة'),
    _SelectionOption(label: 'الجيزة', value: 'الجيزة'),
    _SelectionOption(label: 'الإسكندرية', value: 'الإسكندرية'),
  ];

  static const List<_SelectionOption<String>> _locationAreaOptions = [
    _SelectionOption(label: 'مدينة نصر', value: 'مدينة نصر'),
    _SelectionOption(label: 'المعادي', value: 'المعادي'),
    _SelectionOption(label: 'التجمع الخامس', value: 'التجمع الخامس'),
  ];

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _itemDescriptionController =
      TextEditingController();
  final TextEditingController _dailyPriceController = TextEditingController();
  final TextEditingController _securityDepositController =
      TextEditingController();
  final TextEditingController _productTypeController = TextEditingController(
    text: 'Laptop',
  );
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _termsConditionsController =
      TextEditingController(text: 'لا يوجد');

  final ImagePicker _imagePicker = ImagePicker();

  int? _selectedCategoryId;
  String? _selectedCategoryLabel;
  int? _selectedSubcategoryId;
  String? _selectedSubcategoryLabel;
  String? _selectedCity;
  String? _selectedGovernorate;
  String? _selectedLocationArea;
  bool _isNewCondition = true;

  final List<XFile> _productImages = [];
  final List<XFile> _conditionImages = [];

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemDescriptionController.dispose();
    _dailyPriceController.dispose();
    _securityDepositController.dispose();
    _productTypeController.dispose();
    _brandController.dispose();
    _termsConditionsController.dispose();
    super.dispose();
  }

  int get _productImagesCount => _productImages.length;
  int get _conditionImagesCount => _conditionImages.length;

  List<_SelectionOption<int>> _mapCategoryOptions(
    List<SubCategoryEntity> categories,
  ) {
    return categories
        .map(
          (category) =>
              _SelectionOption(label: category.name, value: category.id),
        )
        .toList();
  }

  List<_SelectionOption<int>> _mapSubcategoryOptions(
    List<SubCategoryEntity> subcategories,
  ) {
    return subcategories
        .map(
          (subcategory) =>
              _SelectionOption(label: subcategory.name, value: subcategory.id),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AddListingCubit>()..loadCategories(),
      child: BlocConsumer<AddListingCubit, AddListingState>(
        listener: (context, state) {
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            showMsg(state.errorMessage!, context);
          }

          if (state.successMessage != null &&
              state.successMessage!.isNotEmpty) {
            showMsg(state.successMessage!, context);
            context.read<AddListingCubit>().clearFeedback();
            context.goNamed(AppRoutes.mainScreen);
          }
        },
        builder: (context, state) {
          final categoryOptions = _mapCategoryOptions(state.categories);
          final subcategoryOptions = _mapSubcategoryOptions(
            state.subcategories,
          );

          return Scaffold(
            backgroundColor: const Color(0xffF5F6FA),
            appBar: AppBar(
              title: Text(
                context.l10n.addListing,
                style: AppStyles.hendi500Size20,
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: PrimaryButtonWidget(
                buttonText: 'إضافة المنتج',
                isLoading: state.isSubmitting,
                enabled: !state.isSubmitting,
                onPress: () => _submitListing(context),
                width: double.infinity,
                height: 52.h,
                icon: Container(
                  width: 22.w,
                  height: 22.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    AppAssets.uiPlus,
                    fit: BoxFit.scaleDown,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                style: AppStyles.hendi500Size20.copyWith(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 16.w,
                vertical: 18.h,
              ),
              child: Column(
                children: [
                  ListingCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.perm_media_outlined,
                                  color: AppColors.primaryColor,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'صور وفيديوهات المنتج',
                                  style: AppStyles.titleMedium.copyWith(
                                    color: AppColors.secondaryColor,
                                    fontSize: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '$_productImagesCount/10',
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.smallSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        ImagePickerGrid(
                          images: _productImages,
                          maxImages: 10,
                          onAdd: () => _pickImages(_productImages),
                          onRemove: (index) {
                            setState(() {
                              _productImages.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  ListingCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.category_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'اختيار الفئة',
                              style: AppStyles.titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        PickerField(
                          hintText: 'اختيار الفئة',
                          value: _selectedCategoryLabel,
                          enabled:
                              !state.isCategoriesLoading &&
                              categoryOptions.isNotEmpty,
                          onTap: () => _pickSelection(
                            context,
                            title: 'اختر الفئة',
                            options: categoryOptions,
                            onSelected: (option) {
                              setState(() {
                                _selectedCategoryId = option.value;
                                _selectedCategoryLabel = option.label;
                                _selectedSubcategoryId = null;
                                _selectedSubcategoryLabel = null;
                              });
                              context.read<AddListingCubit>().loadSubcategories(
                                option.value,
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        PickerField(
                          hintText: state.isSubcategoriesLoading
                              ? 'جارِ تحميل الأنواع الفرعية...'
                              : 'اختيار النوع الفرعي',
                          value: _selectedSubcategoryLabel,
                          enabled:
                              _selectedCategoryId != null &&
                              !state.isSubcategoriesLoading &&
                              subcategoryOptions.isNotEmpty,
                          onTap: _selectedCategoryId == null
                              ? null
                              : () => _pickSelection(
                                  context,
                                  title: 'اختر النوع الفرعي',
                                  options: subcategoryOptions,
                                  onSelected: (option) {
                                    setState(() {
                                      _selectedSubcategoryId = option.value;
                                      _selectedSubcategoryLabel = option.label;
                                    });
                                  },
                                ),
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الموقع',
                              style: AppStyles.titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        PickerField(
                          hintText: 'المدينة',
                          value: _selectedCity,
                          onTap: () => _pickSelection(
                            context,
                            title: 'اختر المدينة',
                            options: _cityOptions,
                            onSelected: (option) {
                              setState(() {
                                _selectedCity = option.value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        PickerField(
                          hintText: 'المنطقة',
                          value: _selectedGovernorate,
                          onTap: () => _pickSelection(
                            context,
                            title: 'اختر المنطقة',
                            options: _governorateOptions,
                            onSelected: (option) {
                              setState(() {
                                _selectedGovernorate = option.value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 10.h),
                        PickerField(
                          hintText: 'منطقة التفاصيل',
                          value: _selectedLocationArea,
                          onTap: () => _pickSelection(
                            context,
                            title: 'اختر المنطقة التفصيلية',
                            options: _locationAreaOptions,
                            onSelected: (option) {
                              setState(() {
                                _selectedLocationArea = option.value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'الحالة',
                              style: AppStyles.titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: ConditionToggleButton(
                                text: 'جديد',
                                isSelected: _isNewCondition,
                                onTap: () {
                                  setState(() {
                                    _isNewCondition = true;
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ConditionToggleButton(
                                text: 'مستعمل',
                                isSelected: !_isNewCondition,
                                onTap: () {
                                  setState(() {
                                    _isNewCondition = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Icon(
                              Icons.edit_note_outlined,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'تفاصيل المنتج',
                              style: AppStyles.titleMedium.copyWith(
                                color: AppColors.secondaryColor,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        LabeledTextField(
                          label: 'اسم العنصر',
                          controller: _itemNameController,
                          hintText: 'اكتب هنا..',
                        ),
                        SizedBox(height: 16.h),
                        LabeledTextField(
                          label: 'وصف العنصر',
                          controller: _itemDescriptionController,
                          hintText: 'اكتب هنا..',
                          maxLines: 4,
                        ),
                        SizedBox(height: 16.h),
                        LabeledTextField(
                          label: 'نوع المنتج',
                          controller: _productTypeController,
                          hintText: 'اكتب هنا..',
                        ),
                        SizedBox(height: 16.h),
                        LabeledTextField(
                          label: 'البراند',
                          controller: _brandController,
                          hintText: 'اكتب هنا..',
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          children: [
                            Expanded(
                              child: PriceField(
                                label: 'سعر الإيجار/يوم',
                                controller: _dailyPriceController,
                                suffix: 'ج.م',
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: PriceField(
                                label: 'سعر التأمين',
                                controller: _securityDepositController,
                                suffix: 'ج.م',
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        LabeledTextField(
                          label: 'شروط الاستخدام',
                          controller: _termsConditionsController,
                          hintText: 'اكتب هنا..',
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  ListingCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.shield_outlined,
                                        color: AppColors.primaryColor,
                                        size: 20.sp,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        'تقرير حالة المنتج',
                                        style: AppStyles.titleMedium.copyWith(
                                          color: AppColors.secondaryColor,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    'قم برفع صور او فيديو لتوضيح العيوب...',
                                    style: AppStyles.bodySmall.copyWith(
                                      color: AppColors.smallSecondaryColor,
                                      height: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '$_conditionImagesCount/10',
                              style: AppStyles.bodySmall.copyWith(
                                color: AppColors.smallSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        ImagePickerGrid(
                          images: _conditionImages,
                          maxImages: 10,
                          onAdd: () => _pickImages(_conditionImages),
                          onRemove: (index) {
                            setState(() {
                              _conditionImages.removeAt(index);
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 110.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImages(List<XFile> targetImages) async {
    final selectedImages = await _imagePicker.pickMultiImage(imageQuality: 85);
    if (selectedImages.isEmpty || !mounted) {
      return;
    }

    setState(() {
      final remainingSlots = 10 - targetImages.length;
      if (remainingSlots <= 0) {
        return;
      }

      targetImages.addAll(selectedImages.take(remainingSlots));
    });
  }

  Future<void> _pickSelection<T>(
    BuildContext context, {
    required String title,
    required List<_SelectionOption<T>> options,
    required void Function(_SelectionOption<T> option) onSelected,
  }) async {
    final selectedOption = await showModalBottomSheet<_SelectionOption<T>>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: Container(
            margin: EdgeInsetsDirectional.only(
              start: 12.w,
              end: 12.w,
              bottom: 12.h,
            ),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.titleMedium.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
                SizedBox(height: 12.h),
                ...options.map(
                  (option) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(option.label),
                    onTap: () => Navigator.of(sheetContext).pop(option),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selectedOption != null && mounted) {
      onSelected(selectedOption);
    }
  }

  String? _validateForm() {
    if (_selectedCategoryId == null) {
      return 'اختيار الفئة مطلوب';
    }
    if (_selectedSubcategoryId == null) {
      return 'اختيار النوع الفرعي مطلوب';
    }
    if (_selectedCity == null) {
      return 'اختيار المدينة مطلوب';
    }
    if (_selectedGovernorate == null) {
      return 'اختيار المنطقة مطلوب';
    }
    if (_selectedLocationArea == null) {
      return 'اختيار المنطقة التفصيلية مطلوب';
    }
    if (_itemNameController.text.trim().isEmpty) {
      return 'اسم المنتج مطلوب';
    }
    if (_itemDescriptionController.text.trim().isEmpty) {
      return 'وصف المنتج مطلوب';
    }
    if (_dailyPriceController.text.trim().isEmpty) {
      return 'سعر الإيجار مطلوب';
    }
    if (_securityDepositController.text.trim().isEmpty) {
      return 'قيمة التأمين مطلوبة';
    }
    final daily = num.tryParse(_dailyPriceController.text.trim());
    if (daily == null || daily <= 0) {
      return 'سعر الإيجار غير صالح';
    }
    final deposit = num.tryParse(_securityDepositController.text.trim());
    if (deposit == null || deposit < 0) {
      return 'قيمة التأمين غير صالحة';
    }
    if (_brandController.text.trim().isEmpty) {
      return 'البراند مطلوب';
    }
    if (_productTypeController.text.trim().isEmpty) {
      return 'نوع المنتج مطلوب';
    }
    if (_termsConditionsController.text.trim().isEmpty) {
      return 'شروط الاستخدام مطلوبة';
    }
    if (_productImages.isEmpty) {
      return 'أضف صورة واحدة على الأقل للمنتج';
    }
    if (_conditionImages.isEmpty) {
      return 'أضف صورة واحدة على الأقل لتقرير الحالة';
    }

    return null;
  }

  void _submitListing(BuildContext context) {
    final validationMessage = _validateForm();
    if (validationMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(validationMessage)));
      return;
    }
    final parsedBasePrice = num.parse(_dailyPriceController.text.trim());

    final request = CreateProductRequest(
      city: _selectedCity!,
      governorate: _selectedGovernorate!,
      categoryId: _selectedCategoryId!,
      subcategoryId: _selectedSubcategoryId!,
      locationArea: _selectedLocationArea!,
      condition: _isNewCondition ? 'New' : 'Used',
      productType: _productTypeController.text,
      brand: _brandController.text,
      rentalGuarantee: _securityDepositController.text,
      name: _itemNameController.text,
      description: _itemDescriptionController.text,
      basePricePerDay: parsedBasePrice,
      termsConditions: _termsConditionsController.text,
      images: [..._productImages, ..._conditionImages],
    );

    context.read<AddListingCubit>().submitListing(request);
  }
}

class _SelectionOption<T> {
  final String label;
  final T value;

  const _SelectionOption({required this.label, required this.value});
}
