import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/feature/add_listing/presentation/widgets/image_picker_grid.dart';
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

class _SubmitCommunityOfferSheetState
    extends State<_SubmitCommunityOfferSheet> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();
  final _messageController = TextEditingController();
  final _governorateController = TextEditingController();
  final _cityController = TextEditingController();
  final _addressController = TextEditingController();
  final _insuranceAmountController = TextEditingController();
  final List<XFile> _images = [];

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
    _insuranceAmountController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final selected = await ImagePicker().pickMultiImage(imageQuality: 85);
    if (selected.isEmpty || !mounted) return;
    final remaining = 10 - _images.length;
    if (remaining <= 0) return;
    setState(() => _images.addAll(selected.take(remaining)));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final insuranceText = _insuranceAmountController.text.trim();

    final success = await context.read<CommunityOffersCubit>().submitOffer(
      CreateCommunityOfferParams(
        requestId: widget.request.id,
        proposedPrice: double.parse(_priceController.text.trim()),
        message: _messageController.text.trim(),
        governorate: _governorateController.text.trim(),
        city: _cityController.text.trim(),
        address: _addressController.text.trim(),
        insuranceAmount: insuranceText.isNotEmpty
            ? double.parse(insuranceText)
            : null,
        image: _images.isNotEmpty ? _images.first : null,
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.submitOffer,
                      style: AppStyles.hendi500Size20.copyWith(
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: const BoxDecoration(
                        color: AppColors.surfaceVariantColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        size: 16.sp,
                        color: AppColors.smallSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                widget.request.title,
                style: AppStyles.bodySmall.copyWith(
                  color: AppColors.smallSecondaryColor,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 20.h),
              _buildSectionLabel('السعر'),
              SizedBox(height: 8.h),
              _buildPriceField(),
              SizedBox(height: 12.h),
              _buildSectionLabel(context.l10n.locationInfo),
              SizedBox(height: 8.h),
              _field(_governorateController, 'المحافظة'),
              _field(_cityController, 'المدينة'),
              _field(_addressController, 'العنوان'),
              SizedBox(height: 16.h),
              _buildSectionLabel('الرسالة'),
              SizedBox(height: 8.h),
              _field(_messageController, 'الرسالة', maxLines: 3),
              SizedBox(height: 16.h),
              _buildSectionLabel(context.l10n.images),
              SizedBox(height: 8.h),
              ImagePickerGrid(
                images: _images,
                maxImages: 1,
                onAdd: _pickImages,
                onRemove: (index) => setState(() => _images.removeAt(index)),
              ),
              SizedBox(height: 20.h),
              BlocConsumer<CommunityOffersCubit, CommunityOffersState>(
                listenWhen: (previous, current) =>
                    previous.errorMessage != current.errorMessage ||
                    previous.actionMessage != current.actionMessage,
                listener: (context, state) {
                  showMsg(state.errorMessage, context, isError: true);
                  showMsg(state.actionMessage, context);
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state.isSubmitting ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: state.isSubmitting
                        ? SizedBox(
                            width: 22.w,
                            height: 22.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            context.l10n.submitOffer,
                            style: AppStyles.buttonLabel.copyWith(
                              fontSize: 15.sp,
                            ),
                          ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Text(
      text,
      style: AppStyles.hendi500Size20.copyWith(
        color: AppColors.secondaryColor,
        fontSize: 15.sp,
      ),
    );
  }

  Widget _buildPriceField() {
    return TextFormField(
      controller: _priceController,
      keyboardType: TextInputType.number,
      validator: (value) => value == null || value.trim().isEmpty
          ? context.l10n.requiredField
          : null,
      decoration: InputDecoration(
        labelText: 'السعر المقترح',
        hintText: context.l10n.egpCurrency,
        labelStyle: AppStyles.bodyMedium.copyWith(
          color: AppColors.smallSecondaryColor,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: AppColors.primaryColor),
        ),
        contentPadding: EdgeInsetsDirectional.symmetric(
          horizontal: 14.w,
          vertical: 12.h,
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
        validator: (value) => value == null || value.trim().isEmpty
            ? context.l10n.requiredField
            : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: AppStyles.bodyMedium.copyWith(
            color: AppColors.smallSecondaryColor,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: AppColors.primaryColor),
          ),
          contentPadding: EdgeInsetsDirectional.symmetric(
            horizontal: 14.w,
            vertical: 12.h,
          ),
        ),
      ),
    );
  }
}
