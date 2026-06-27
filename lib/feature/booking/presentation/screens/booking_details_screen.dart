import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_item_card_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_stepper_widget.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/core/widgets/custom_text_field.dart';

/// First step of booking flow - showing booking details with location and dates
class BookingDetailsScreen extends StatefulWidget {
  final ProductEntity product;
  final void Function(
    int step,
    DateTime startDate,
    DateTime endDate,
    String street,
    String city,
    String governorate,
  )?
  onNextStep;
  final VoidCallback? onBackPressed;

  const BookingDetailsScreen({
    super.key,
    required this.product,
    this.onNextStep,
    this.onBackPressed,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  DateTime selectedPickupDate = DateTime.now();
  DateTime selectedDropoffDate = DateTime.now().add(const Duration(days: 5));

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _governorateController = TextEditingController();

  @override
  void dispose() {
    _streetController.dispose();
    _cityController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPickup ? selectedPickupDate : selectedDropoffDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && mounted) {
      setState(() {
        if (isPickup) {
          selectedPickupDate = picked;
          if (selectedDropoffDate.isBefore(selectedPickupDate)) {
            selectedDropoffDate = selectedPickupDate.add(
              const Duration(days: 1),
            );
          }
        } else {
          if (picked.isBefore(selectedPickupDate)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.l10n.returnDateAfterPickup)),
            );
            return;
          }
          selectedDropoffDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    int days = selectedDropoffDate.difference(selectedPickupDate).inDays;
    if (days <= 0) days = 1;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(context.l10n.bookings, style: AppStyles.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stepper
              BookingStepperWidget(currentStep: 1),
              verticalSpacing(24),

              // Product Card
              Text(context.l10n.productDetails, style: AppStyles.titleMedium),
              verticalSpacing(12),
              BookingItemCardWidget(
                productName: widget.product.name,
                location: widget.product.locationArea,
                rating: 4.5, // placeholder or widget.product.rating
                reviewCount: 128, // placeholder
                imageUrl: widget.product.images.isNotEmpty
                    ? widget.product.images.first
                    : 'https://via.placeholder.com/200',
              ),
              verticalSpacing(24),

              // Dates Selection
              Text(context.l10n.selectDates, style: AppStyles.titleMedium),
              verticalSpacing(12),
              Row(
                children: [
                  Expanded(
                    child: _DateTile(
                      label: context.l10n.pickupDate,
                      date: selectedPickupDate,
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  horizontalSpacing(12),
                  Expanded(
                    child: _DateTile(
                      label: context.l10n.returnDate,
                      date: selectedDropoffDate,
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              verticalSpacing(24),

              // Location Form
              Text(context.l10n.deliveryDetails, style: AppStyles.titleMedium),
              verticalSpacing(12),
              CustomTextField(
                controller: _governorateController,
                hintText: context.l10n.governorate,
                validator: (val) => val == null || val.isEmpty
                    ? context.l10n.requiredField
                    : null,
              ),
              verticalSpacing(12),
              CustomTextField(
                controller: _cityController,
                hintText: context.l10n.city,
                validator: (val) => val == null || val.isEmpty
                    ? context.l10n.requiredField
                    : null,
              ),
              verticalSpacing(12),
              CustomTextField(
                controller: _streetController,
                hintText: context.l10n.streetAddress,
                validator: (val) => val == null || val.isEmpty
                    ? context.l10n.requiredField
                    : null,
              ),
              verticalSpacing(24),

              // // Pricing Summary
              // Text('ملخص الأسعار ($days أيام)', style: AppStyles.titleMedium),
              // verticalSpacing(12),
              // PaymentSummaryWidget(
              //   rentalPrice: rentalPrice,
              //   insurancePrice: insurancePrice,
              //   servicePrice: servicePrice,
              //   totalPrice: totalPrice,
              // ),
              // verticalSpacing(32),

              // Next Button
              PrimaryButtonWidget(
                width: double.infinity,
                buttonText: context.l10n.continueText,
                onPress: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    widget.onNextStep?.call(
                      2,
                      selectedPickupDate,
                      selectedDropoffDate,
                      _streetController.text,
                      _cityController.text,
                      _governorateController.text,
                    );
                  }
                },
              ),
              verticalSpacing(16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime date;
  final VoidCallback onTap;

  const _DateTile({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: AppStyles.bodySmall.copyWith(color: Colors.grey.shade600),
            ),
            verticalSpacing(4),
            Text(
              '${date.day}/${date.month}/${date.year}',
              style: AppStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
