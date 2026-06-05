import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';

Future<void> showSubmitCommunityOfferSheet(
  BuildContext context,
  CommunityRequestEntity request,
) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (sheetContext) => BlocProvider.value(
      value: context.read<CommunityOffersCubit>(),
      child: _SubmitCommunityOfferSheet(request: request),
    ),
  );
}

class _SubmitCommunityOfferSheet extends StatefulWidget {
  const _SubmitCommunityOfferSheet({required this.request});

  final CommunityRequestEntity request;

  @override
  State<_SubmitCommunityOfferSheet> createState() =>
      _SubmitCommunityOfferSheetState();
}

class _SubmitCommunityOfferSheetState extends State<_SubmitCommunityOfferSheet> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _messageController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _governorateController.text = widget.request.governorate;
    _cityController.text = widget.request.city;
    _addressController.text = widget.request.address;
    _priceController.text = widget.request.budget > 0
        ? widget.request.budget.toStringAsFixed(0)
        : '';
  }

  @override
  void dispose() {
    _priceController.dispose();
    _messageController.dispose();
    _governorateController.dispose();
    _cityController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final success = await context.read<CommunityOffersCubit>().submitOffer(
      CreateCommunityOfferParams(
        requestId: widget.request.id,
        proposedPrice: double.parse(_priceController.text.trim()),
        message: _messageController.text.trim(),
        governorate: _governorateController.text.trim(),
        city: _cityController.text.trim(),
        address: _addressController.text.trim(),
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
              Text('تقديم عرض', style: AppStyles.hendi500Size20),
              SizedBox(height: 8.h),
              Text(
                widget.request.title,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.smallSecondaryColor,
                ),
              ),
              SizedBox(height: 12.h),
              _field(_priceController, 'السعر المقترح', keyboardType: TextInputType.number),
              _field(_messageController, 'الرسالة', maxLines: 3),
              _field(_governorateController, 'المحافظة'),
              _field(_cityController, 'المدينة'),
              _field(_addressController, 'العنوان'),
              SizedBox(height: 16.h),
              BlocBuilder<CommunityOffersCubit, CommunityOffersState>(
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
                        : const Text('إرسال العرض'),
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
