import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/primary_outline_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_stepper_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/insurance_option_widget.dart';

/// Second step of booking flow - selecting insurance and contract review
class BookingInsuranceScreen extends StatefulWidget {
  final void Function(int step)? onNextStep;
  final void Function()? onPreviousStep;

  const BookingInsuranceScreen({
    super.key,
    this.onNextStep,
    this.onPreviousStep,
  });

  @override
  State<BookingInsuranceScreen> createState() => _BookingInsuranceScreenState();
}

class _BookingInsuranceScreenState extends State<BookingInsuranceScreen> {
  int selectedInsurance = 0; // 0 = first option, 1 = second option

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
            BookingStepperWidget(currentStep: 2),
            verticalSpacing(24),

            // Insurance Title
            Text('نطقة التأمين الشامل', style: AppStyles.titleMedium),
            verticalSpacing(8),
            Text(
              'حماية لممتلكاتك المستأجرة والاحتفاظ بالمسؤولية والأحكام التالية:',
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.textSecondaryColor,
              ),
            ),
            verticalSpacing(16),

            // Insurance Options
            InsuranceOptionWidget(
              insuranceTitle: 'نطقة التأمين الشامل',
              insuranceDescription:
                  'حماية لممتلكاتك المستأجرة والاحتفاظ بالمسؤولية والأحكام التالية:',
              monthlyPrice: 100,
              deductiblePrice: 90,
              servicePrice: 0,
              totalPrice: 190,
              isSelected: selectedInsurance == 0,
              onSelect: () => setState(() => selectedInsurance = 0),
              icon: Icons.security_outlined,
            ),
            verticalSpacing(16),

            InsuranceOptionWidget(
              insuranceTitle: 'عقد تأجير معدات الكترونية',
              insuranceDescription:
                  'هذا العقد بين "المؤجر" و "المستأجر" وفقا للشروط والأحكام التالية:',
              monthlyPrice: 100,
              deductiblePrice: 90,
              servicePrice: 0,
              totalPrice: 190,
              isSelected: selectedInsurance == 1,
              onSelect: () => setState(() => selectedInsurance = 1),
              icon: Icons.description_outlined,
            ),
            verticalSpacing(24),

            // Agreement Section
            _AgreementSection(),
            verticalSpacing(32),

            // Action Buttons
            PrimaryButtonWidget(
              buttonText: 'متابعة إلى الدفع',
              onPress: () {
                // Navigate to payment screen
                widget.onNextStep?.call(3);
              },
            ),
            verticalSpacing(12),
            PrimaryOutlineButtonWidget(
              text: 'العودة',
              onPressed: () {
                // Go back to details
                widget.onPreviousStep?.call();
              },
            ),
            verticalSpacing(16),
          ],
        ),
      ),
    );
  }
}

class _AgreementSection extends StatefulWidget {
  @override
  State<_AgreementSection> createState() => _AgreementSectionState();
}

class _AgreementSectionState extends State<_AgreementSection> {
  bool agreedToTerms = false;
  bool agreedToInsurance = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primarySoftColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Agreements
          Row(
            children: [
              Checkbox(
                value: agreedToTerms,
                onChanged: (value) =>
                    setState(() => agreedToTerms = value ?? false),
                activeColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.borderColor, width: 2),
              ),
              Expanded(
                child: Text(
                  'أوافق على جميع نصوص العقد والتعاريف للشروط الواردة',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
          verticalSpacing(12),
          Row(
            children: [
              Checkbox(
                value: agreedToInsurance,
                onChanged: (value) =>
                    setState(() => agreedToInsurance = value ?? false),
                activeColor: AppColors.primaryColor,
                side: BorderSide(color: AppColors.borderColor, width: 2),
              ),
              Expanded(
                child: Text(
                  'أوافق على رسوم التأمين الموضحة اعلاه ولا يحق لي الاعتراض عليها',
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
