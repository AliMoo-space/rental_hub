import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_item_card_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_location_section_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_stepper_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/payment_summary_widget.dart';

/// First step of booking flow - showing booking details with location and dates
class BookingDetailsScreen extends StatefulWidget {
  final void Function(int step)? onNextStep;

  const BookingDetailsScreen({super.key, this.onNextStep});

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  DateTime selectedPickupDate = DateTime.now();
  DateTime selectedDropoffDate = DateTime.now().add(const Duration(days: 5));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(context.l10n.bookings, style: AppStyles.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stepper
            BookingStepperWidget(currentStep: 1),
            verticalSpacing(24),

            // Product Card
            Text('تفاصيل المنتج', style: AppStyles.titleMedium),
            verticalSpacing(12),
            BookingItemCardWidget(
              productName: 'Canon Camera',
              location: 'Cairo, Egypt',
              rating: 4.5,
              reviewCount: 128,
              imageUrl: 'https://via.placeholder.com/200x200?text=Canon+Camera',
            ),
            verticalSpacing(24),

            // Location Section
            Text('تحديد الموقع', style: AppStyles.titleMedium),
            verticalSpacing(12),
            BookingLocationSectionWidget(
              pickupLocation: 'Cairo, Egypt',
              dropoffLocation: 'Cairo, Egypt',
              pickupDate: selectedPickupDate,
              dropoffDate: selectedDropoffDate,
              onLocationTap: _openLocationPicker,
            ),
            verticalSpacing(24),

            // Pricing Summary
            Text('ملخص الأسعار', style: AppStyles.titleMedium),
            verticalSpacing(12),
            PaymentSummaryWidget(
              rentalPrice: 750,
              insurancePrice: 190,
              servicePrice: 100,
              totalPrice: 1040,
            ),
            verticalSpacing(32),

            // Next Button
            PrimaryButtonWidget(
              buttonText: 'متابعة',
              onPress: () {
                // Navigate to insurance screen
                widget.onNextStep?.call(2);
              },
            ),
            verticalSpacing(16),
          ],
        ),
      ),
    );
  }

  void _openLocationPicker() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Location picker - implement as needed'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
