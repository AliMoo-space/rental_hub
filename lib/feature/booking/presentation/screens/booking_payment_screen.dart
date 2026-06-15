import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_item_card_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_stepper_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/payment_summary_widget.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

/// Final step of booking flow - payment confirmation
class BookingPaymentScreen extends StatefulWidget {
  final ProductEntity product;
  final int days;
  final bool isLoading;
  final void Function()? onPreviousStep;
  final void Function()? onConfirmPayment;

  const BookingPaymentScreen({
    super.key,
    required this.product,
    required this.days,
    this.isLoading = false,
    this.onPreviousStep,
    this.onConfirmPayment,
  });

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  @override
  Widget build(BuildContext context) {
    final double rentalPrice =
        widget.product.basePricePerDay.toDouble() * widget.days;
    final double insurancePrice = rentalPrice * 0.1; // Example 10%
    final double servicePrice = rentalPrice * 0.05; // Example 5%
    final double totalPrice = rentalPrice + insurancePrice + servicePrice;

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
            BookingStepperWidget(currentStep: 3),
            verticalSpacing(24),

            // Product Header
            Text('تفاصيل الفاتورة', style: AppStyles.titleMedium),
            verticalSpacing(12),

            // Product Card
            BookingItemCardWidget(
              productName: widget.product.name,
              location: widget.product.locationArea,
              rating: 4.5,
              reviewCount: 128,
              imageUrl: widget.product.images.isNotEmpty
                  ? widget.product.images.first
                  : 'https://via.placeholder.com/200',
            ),
            verticalSpacing(24),

            // Pricing Breakdown
            Text('تفاصيل الدفع', style: AppStyles.titleMedium),
            verticalSpacing(12),
            PaymentSummaryWidget(
              rentalPrice: rentalPrice,
              insurancePrice: insurancePrice,
              servicePrice: servicePrice,
              totalPrice: totalPrice,
            ),
            verticalSpacing(24),

            // Payment Method Section
            Text('طريقة الدفع', style: AppStyles.titleMedium),
            verticalSpacing(12),
            _PaymentMethodTile(
              icon: Icons.account_balance_wallet_outlined,
              title: 'رصيد المحفظة',
              subtitle: '12,000.00 ج.م',
            ),
            verticalSpacing(32),

            // Confirmation Note
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.successColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.successColor.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    color: AppColors.successColor,
                    size: 20.w,
                  ),
                  horizontalSpacing(12),
                  Expanded(
                    child: Text(
                      'الموافقة على الشروط والأحكام الخاصة بالاستئجار',
                      style: AppStyles.bodySmall.copyWith(
                        color: AppColors.successColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            verticalSpacing(32),

            // Confirm Button
            widget.isLoading
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButtonWidget(
                    width: double.infinity,
                    buttonText: 'تأكيد الحجز',
                    onPress: () {
                      widget.onConfirmPayment?.call();
                    },
                  ),
            verticalSpacing(12),

            // Back Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50.h),
                side: const BorderSide(color: AppColors.primaryColor, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.r),
                ),
              ),
              onPressed: () {
                widget.onPreviousStep?.call();
              },
              child: Text(
                'العودة',
                style: AppStyles.bodyLarge.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            verticalSpacing(16),
          ],
        ),
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _PaymentMethodTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.primaryColor, width: 2),
      ),
      child: Row(
        children: [
          Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              color: AppColors.primarySoftColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor, size: 24.w),
          ),
          horizontalSpacing(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  subtitle,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.check_circle, color: AppColors.successColor, size: 24.w),
        ],
      ),
    );
  }
}
