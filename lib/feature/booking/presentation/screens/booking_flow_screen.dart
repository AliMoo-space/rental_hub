import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_state.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_details_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_insurance_screen.dart';
import 'package:rental_hub/feature/booking/presentation/screens/booking_payment_screen.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/booking_flow_state_listener.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class BookingFlowScreen extends StatefulWidget {
  final ProductEntity product;
  const BookingFlowScreen({super.key, required this.product});

  @override
  State<BookingFlowScreen> createState() => _BookingFlowScreenState();
}

class _BookingFlowScreenState extends State<BookingFlowScreen> {
  static const int _totalSteps = 3;

  late final PageController _pageController;
  int _currentPageIndex = 0;

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 5));
  String _street = '';
  String _city = '';
  String _governorate = '';
  final String _deliveryMethod = 'Pickup';

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

  int get _rentalDays {
    final days = _endDate.difference(_startDate).inDays;
    return days > 0 ? days : 1;
  }

  void _goToStep(int step) {
    final pageIndex = (step - 1).clamp(0, _totalSteps - 1);
    if (!_pageController.hasClients) return;
    if (_pageController.page?.round() == pageIndex) return;

    _pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handleSystemBack() {
    if (_currentPageIndex > 0) {
      _goToStep(_currentPageIndex);
    } else {
      Navigator.of(context).pop();
    }
  }

  void _confirmPayment(BuildContext blocContext) {
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
    blocContext.read<BookingActionCubit>().createRentalOrder(dto);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BookingActionCubit>(),
      child: BookingFlowStateListener(
        child: BlocBuilder<BookingActionCubit, BookingActionState>(
          buildWhen: (previous, current) {
            final wasLoading = previous is BookingActionLoading;
            final isLoading = current is BookingActionLoading;
            return wasLoading != isLoading;
          },
          builder: (context, state) {
            final isLoading = state is BookingActionLoading;

            return PopScope(
              canPop: _currentPageIndex == 0,
              onPopInvokedWithResult: (didPop, _) {
                if (!didPop) _handleSystemBack();
              },
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => _currentPageIndex = index);
                },
                children: [
                  BookingDetailsScreen(
                    product: widget.product,
                    onBackPressed: () => Navigator.of(context).pop(),
                    onNextStep:
                        (step, startDate, endDate, street, city, governorate) {
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
                    onBackPressed: () => _goToStep(1),
                    onNextStep: _goToStep,
                    onPreviousStep: () => _goToStep(1),
                  ),
                  BookingPaymentScreen(
                    product: widget.product,
                    days: _rentalDays,
                    isLoading: isLoading,
                    onBackPressed: () => _goToStep(2),
                    onPreviousStep: () => _goToStep(2),
                    onConfirmPayment: () => _confirmPayment(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
