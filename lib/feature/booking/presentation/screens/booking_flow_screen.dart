import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_state.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_details_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_insurance_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_payment_screen.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class BookingFlowScreen extends StatefulWidget {
  final ProductEntity product;
  const BookingFlowScreen({super.key, required this.product});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  late PageController _pageController;

  // Collected data
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 5));
  String _street = '';
  String _city = '';
  String _governorate = '';
  String _deliveryMethod = 'Pickup';

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
    return BlocProvider(
      create: (context) => getIt<BookingActionCubit>(),
      child: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          BookingDetailsScreen(
            product: widget.product,
            onNextStep: (step, startDate, endDate, street, city, governorate) {
              setState(() {
                _startDate = startDate;
                _endDate = endDate;
                _street = street;
                _city = city;
                _governorate = governorate;
              });
              _goToStep(step);
            },
          ),
          BookingInsuranceScreen(
            onNextStep: (step) {
              _goToStep(step);
            },
            onPreviousStep: () {
              _goToStep(1);
            },
          ),
          // Step 3: Payment Confirmation
          BlocListener<BookingActionCubit, BookingActionState>(
            listener: (context, state) {
              if (state is BookingActionSuccess) {
                Navigator.pop(context, true);
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage)));
              } else if (state is BookingActionFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
            },
            child: BlocBuilder<BookingActionCubit, BookingActionState>(
              builder: (context, state) {
                return BookingPaymentScreen(
                  product: widget.product,
                  days: _endDate.difference(_startDate).inDays > 0
                      ? _endDate.difference(_startDate).inDays
                      : 1,
                  isLoading: state is BookingActionLoading,
                  onPreviousStep: () {
                    _goToStep(2);
                  },
                  onConfirmPayment: () {
                    final dto = CreateRentalOrderDto(
                      productId: widget.product.id,
                      startDate: _startDate,
                      endDate: _endDate,
                      deliveryMethod: _deliveryMethod,
                      street: _street,
                      city: _city,
                      governorate: _governorate,
                      termsAgreed: true,
                    );
                    context.read<BookingActionCubit>().createRentalOrder(dto);
                  },
                );
              },
            ),
          ),
        ],
      ),
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
