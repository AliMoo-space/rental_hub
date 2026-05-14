import 'package:flutter/material.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_details_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_insurance_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_payment_screen.dart';

/// Container screen that manages the booking flow navigation between 3 steps
class BookingFlowScreen extends StatefulWidget {
  const BookingFlowScreen({super.key});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(), // Prevent manual swiping
      children: [
        // Step 1: Booking Details
        BookingDetailsScreen(
          onNextStep: (step) {
            _goToStep(step);
          },
        ),
        // Step 2: Insurance Selection
        BookingInsuranceScreen(
          onNextStep: (step) {
            _goToStep(step);
          },
          onPreviousStep: () {
            _goToStep(1);
          },
        ),
        // Step 3: Payment Confirmation
        BookingPaymentScreen(
          onPreviousStep: () {
            _goToStep(2);
          },
          onConfirmPayment: () {
            // Handle successful booking
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _goToStep(int step) {
    _pageController.animateToPage(
      step - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
