import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';

Future<void> showCreateCommunityRequestSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetContext) => BlocProvider.value(
      value: context.read<CommunityRequestsCubit>(),
      child: const _CreateCommunityRequestSheet(),
    ),
  );
}

class _CreateCommunityRequestSheet extends StatefulWidget {
  const _CreateCommunityRequestSheet();

  @override
  State<_CreateCommunityRequestSheet> createState() =>
      _CreateCommunityRequestSheetState();
}

class _CreateCommunityRequestSheetState extends State<_CreateCommunityRequestSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _budgetController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _categoryIdController = TextEditingController(text: '1');
  final _subcategoryIdController = TextEditingController(text: '1');

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 2));
  XFile? _image;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _budgetController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    _categoryIdController.dispose();
    _subcategoryIdController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _image = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await context.read<CommunityRequestsCubit>().createRequest(
      CreateCommunityRequestParams(
        categoryId: int.parse(_categoryIdController.text.trim()),
        subcategoryId: int.parse(_subcategoryIdController.text.trim()),
        governorate: _governorateController.text.trim(),
        city: _cityController.text.trim(),
        address: _addressController.text.trim(),
        title: _titleController.text.trim(),
        budget: double.parse(_budgetController.text.trim()),
        startDate: _startDate,
        endDate: _endDate,
        description: _descriptionController.text.trim(),
        image: _image,
      ),
    );

    if (success && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 18.w,
        end: 18.w,
        top: 16.h,
        bottom: bottomInset + 20.h,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('إضافة طلب مجتمع', style: AppStyles.hendi500Size20),
              SizedBox(height: 12.h),
              _field(_titleController, 'العنوان'),
              _field(_descriptionController, 'الوصف', maxLines: 3),
              _field(_budgetController, 'الميزانية', keyboardType: TextInputType.number),
              _field(_governorateController, 'المحافظة'),
              _field(_cityController, 'المدينة'),
              _field(_addressController, 'العنوان التفصيلي'),
              _field(_categoryIdController, 'رقم التصنيف', keyboardType: TextInputType.number),
              _field(
                _subcategoryIdController,
                'رقم التصنيف الفرعي',
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8.h),
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image_outlined),
                label: Text(_image == null ? 'إضافة صورة' : 'تم اختيار صورة'),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<CommunityRequestsCubit, CommunityRequestsState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('نشر الطلب'),
                  );
                },
              ),
            ],
          ),
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
