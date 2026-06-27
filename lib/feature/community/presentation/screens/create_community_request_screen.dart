import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/image_picker_grid.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/picker_field.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/home/domain/entities/category_entity.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_category.dart';
import 'package:rental_hub/feature/home/domain/usecases/get_subcategories_usecase.dart';

class _SelectionOption<T> {
  final String label;
  final T value;
  const _SelectionOption({required this.label, required this.value});
}

class CreateCommunityRequestScreen extends StatefulWidget {
  const CreateCommunityRequestScreen({super.key});

  @override
  State<CreateCommunityRequestScreen> createState() =>
      _CreateCommunityRequestScreenState();
}

class _CreateCommunityRequestScreenState
    extends State<CreateCommunityRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  final List<XFile> _images = [];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 2));

  int? _selectedCategoryId;
  String? _selectedCategoryLabel;
  int? _selectedSubcategoryId;
  String? _selectedSubcategoryLabel;

  List<_SelectionOption<int>> _categoryOptions = [];
  List<_SelectionOption<int>> _subcategoryOptions = [];
  bool _isLoadingCategories = true;
  bool _isLoadingSubcategories = false;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoadingCategories = true);
    final result = await getIt<GetCategory>()();
    result.fold(
      (_) {
        if (mounted) setState(() => _isLoadingCategories = false);
      },
      (categories) {
        if (!mounted) return;
        final flattened = categories
            .expand<SubCategoryEntity>((cat) => cat.items)
            .toList();
        setState(() {
          _categoryOptions = flattened
              .map((sc) => _SelectionOption(label: sc.name, value: sc.id))
              .toList();
          _isLoadingCategories = false;
        });
      },
    );
  }

  Future<void> _loadSubcategories(int categoryId) async {
    setState(() => _isLoadingSubcategories = true);
    final result = await getIt<GetSubcategoriesUseCase>()(categoryId);
    result.fold(
      (_) {
        if (mounted) setState(() => _isLoadingSubcategories = false);
      },
      (subcategories) {
        if (!mounted) return;
        setState(() {
          _subcategoryOptions = subcategories
              .map((sc) => _SelectionOption(label: sc.name, value: sc.id))
              .toList();
          _isLoadingSubcategories = false;
        });
      },
    );
  }

  Future<void> _pickImages() async {
    final selected = await ImagePicker().pickMultiImage(imageQuality: 85);
    if (selected.isEmpty || !mounted) return;
    final remaining = 10 - _images.length;
    if (remaining <= 0) return;
    setState(() => _images.addAll(selected.take(remaining)));
  }

  Future<void> _pickSelection(
    BuildContext context, {
    required String title,
    required List<_SelectionOption<int>> options,
    required void Function(_SelectionOption<int> option) onSelected,
  }) async {
    final selectedOption = await showModalBottomSheet<_SelectionOption<int>>(
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
                SizedBox(
                  height: 300,
                  child: ListView(
                    children: options
                        .map(
                          (option) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(option.label),
                            onTap: () => Navigator.of(sheetContext).pop(option),
                          ),
                        )
                        .toList(),
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

  Future<void> _pickDate(bool isStart) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: isStart ? now : _startDate,
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate.isBefore(_startDate)) {
            _endDate = _startDate.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<CommunityRequestsCubit>();
    final success = await cubit.createRequest(
      CreateCommunityRequestParams(
        categoryId: _selectedCategoryId ?? 0,
        subcategoryId: _selectedSubcategoryId ?? 0,
        governorate: _governorateController.text.trim(),
        city: _cityController.text.trim(),
        address: _addressController.text.trim(),
        title: _titleController.text.trim(),
        budget: double.parse(_budgetController.text.trim()),
        startDate: _startDate,
        endDate: _endDate,
        description: _descriptionController.text.trim(),
        image: _images.isNotEmpty ? _images.first : null,
      ),
    );

    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة طلب مجتمع')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(
            horizontal: 18.w,
            vertical: 20.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSectionLabel('التصنيف'),
              SizedBox(height: 8.h),
              if (_isLoadingCategories)
                const Center(child: CircularProgressIndicator())
              else ...[
                PickerField(
                  hintText: 'اختيار التصنيف',
                  value: _selectedCategoryLabel,
                  enabled: _categoryOptions.isNotEmpty,
                  onTap: () => _pickSelection(
                    context,
                    title: 'اختر التصنيف',
                    options: _categoryOptions,
                    onSelected: (option) {
                      setState(() {
                        _selectedCategoryId = option.value;
                        _selectedCategoryLabel = option.label;
                        _selectedSubcategoryId = null;
                        _selectedSubcategoryLabel = null;
                        _subcategoryOptions = [];
                      });
                      _loadSubcategories(option.value);
                    },
                  ),
                ),
                SizedBox(height: 10.h),
                PickerField(
                  hintText: _isLoadingSubcategories
                      ? 'جارِ تحميل الأنواع الفرعية...'
                      : 'اختيار النوع الفرعي',
                  value: _selectedSubcategoryLabel,
                  enabled:
                      _selectedCategoryId != null &&
                      !_isLoadingSubcategories &&
                      _subcategoryOptions.isNotEmpty,
                  onTap: _selectedCategoryId == null
                      ? null
                      : () => _pickSelection(
                          context,
                          title: 'اختر النوع الفرعي',
                          options: _subcategoryOptions,
                          onSelected: (option) {
                            setState(() {
                              _selectedSubcategoryId = option.value;
                              _selectedSubcategoryLabel = option.label;
                            });
                          },
                        ),
                ),
              ],
              SizedBox(height: 20.h),
              _buildSectionLabel('الموقع'),
              SizedBox(height: 8.h),
              _field(_governorateController, 'المحافظة'),
              _field(_cityController, 'المدينة'),
              _field(_addressController, 'العنوان التفصيلي'),
              SizedBox(height: 20.h),
              _buildSectionLabel('تفاصيل الطلب'),
              SizedBox(height: 8.h),
              _field(_titleController, 'العنوان'),
              _field(_descriptionController, 'الوصف', maxLines: 3),
              _field(
                _budgetController,
                'الميزانية',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 12.h),
              _buildDateRow('تاريخ البدء', _startDate, true),
              SizedBox(height: 10.h),
              _buildDateRow('تاريخ الانتهاء', _endDate, false),
              SizedBox(height: 20.h),
              _buildSectionLabel('الصور'),
              SizedBox(height: 8.h),
              ImagePickerGrid(
                images: _images,
                maxImages: 1,
                onAdd: _pickImages,
                onRemove: (index) => setState(() => _images.removeAt(index)),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<CommunityRequestsCubit, CommunityRequestsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text(
                            'نشر الطلب',
                            style: TextStyle(fontSize: 16),
                          ),
                  );
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: AppStyles.hendi500Size20.copyWith(color: AppColors.secondaryColor),
    );
  }

  Widget _buildDateRow(String label, DateTime date, bool isStart) {
    return InkWell(
      onTap: () => _pickDate(isStart),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceColor,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 18.sp,
              color: AppColors.smallSecondaryColor,
            ),
            SizedBox(width: 10.w),
            Text(
              label,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.smallSecondaryColor,
              ),
            ),
            const Spacer(),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'مطلوب' : null,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
