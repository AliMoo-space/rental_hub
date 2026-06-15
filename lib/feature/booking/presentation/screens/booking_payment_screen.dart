import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
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
  final VoidCallback? onBackPressed;
  final void Function()? onPreviousStep;
  final void Function()? onConfirmPayment;

  const BookingPaymentScreen({
    super.key,
    required this.product,
    required this.days,
    this.isLoading = false,
    this.onBackPressed,
    this.onPreviousStep,
    this.onConfirmPayment,
  });

  @override
  State<BookingPaymentScreen> createState() => _BookingPaymentScreenState();
}

class _BookingPaymentScreenState extends State<BookingPaymentScreen> {
  void _handleConfirmPayment() {
    final onConfirm = widget.onConfirmPayment;
    if (onConfirm != null) {
      onConfirm();
      return;
    }

    showMsg(
      'تعذر إتمام الدفع. يرجى المحاولة مرة أخرى.',
      context,
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final breakdown = _BookingPaymentBreakdown.from(
      product: widget.product,
      days: widget.days,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF5F6FA),
      appBar: AppBar(
        title: Text(context.l10n.bookings, style: AppStyles.titleMedium),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: widget.onBackPressed ?? () => Navigator.pop(context),
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
              rating: widget.product.averageRating,
              reviewCount: widget.product.totalReviews,
              imageUrl: widget.product.images.isNotEmpty
                  ? widget.product.images.first
                  : 'https://via.placeholder.com/200',
            ),
            verticalSpacing(24),

            // Pricing Breakdown
            Text('تفاصيل الدفع', style: AppStyles.titleMedium),
            verticalSpacing(12),
            PaymentSummaryWidget(
              rentalPrice: breakdown.rentalPrice,
              insurancePrice: breakdown.insurancePrice,
              servicePrice: breakdown.servicePrice,
              totalPrice: breakdown.totalPrice,
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
                    onPress: _handleConfirmPayment,
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

class _BookingPaymentBreakdown {
  final double rentalPrice;
  final double insurancePrice;
  final double servicePrice;
  final double totalPrice;

  const _BookingPaymentBreakdown({
    required this.rentalPrice,
    required this.insurancePrice,
    required this.servicePrice,
    required this.totalPrice,
  });

  factory _BookingPaymentBreakdown.from({
    required ProductEntity product,
    required int days,
  }) {
    final rentalDays = days > 0 ? days : 1;
    final pricePerDay = _resolvePricePerDay(product);
    final rentalPrice = pricePerDay * rentalDays;
    final insurancePrice = rentalPrice * 0.1;
    final commission = product.commissionPercentage.toDouble();
    final servicePrice = commission > 0
        ? rentalPrice * (commission / 100)
        : rentalPrice * 0.05;
    final totalPrice = rentalPrice + insurancePrice + servicePrice;

    return _BookingPaymentBreakdown(
      rentalPrice: rentalPrice,
      insurancePrice: insurancePrice,
      servicePrice: servicePrice,
      totalPrice: totalPrice,
    );
  }

  static double _resolvePricePerDay(ProductEntity product) {
    final finalPrice = product.finalPricePerDay.toDouble();
    if (finalPrice > 0) return finalPrice;

    final basePrice = product.basePricePerDay.toDouble();
    if (basePrice > 0) return basePrice;

    return 0;
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
