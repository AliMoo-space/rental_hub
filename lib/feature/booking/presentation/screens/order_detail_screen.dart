import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/domain/entities/rental_order_entity.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/booking_action_state.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/order_detail_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/order_detail_state.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_action_buttons.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_info_row.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_product_card.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_timeline_widget.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/profile_error_state.dart';

class OrderDetailScreen extends StatefulWidget {
  final int orderId;
  final RentalOrderEntity? previewOrder;

  const OrderDetailScreen({
    super.key,
    required this.orderId,
    this.previewOrder,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    _resolveCurrentUser();
  }

  Future<void> _resolveCurrentUser() async {
    final userId = await getIt<TokenStorageHelper>().getCurrentUserId();
    if (!mounted) return;
    setState(() => _currentUserId = userId ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<OrderDetailCubit>()
            ..loadOrder(widget.orderId, currentUserId: _currentUserId ?? ''),
        ),
        BlocProvider(create: (context) => getIt<BookingActionCubit>()),
      ],
      child: _Body(
        orderId: widget.orderId,
        previewOrder: widget.previewOrder,
        currentUserId: _currentUserId ?? '',
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final int orderId;
  final RentalOrderEntity? previewOrder;
  final String currentUserId;

  const _Body({
    required this.orderId,
    this.previewOrder,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<BookingActionCubit, BookingActionState>(
      listenWhen: (_, current) =>
          current is BookingActionSuccess || current is BookingActionFailure,
      listener: (context, state) {
        if (!context.mounted) return;
        final messenger = ScaffoldMessenger.of(context);
        if (state is BookingActionSuccess) {
          messenger.showSnackBar(SnackBar(content: Text(state.errMessage)));
          context.read<OrderDetailCubit>().loadOrder(
            orderId,
            currentUserId: currentUserId,
          );
        } else if (state is BookingActionFailure) {
          messenger.showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '${context.l10n.orderDetailLabel} #$orderId',
            style: AppStyles.hendi500Size20,
          ),
        ),
        body: BlocBuilder<OrderDetailCubit, OrderDetailState>(
          builder: (context, state) {
            if (state is OrderDetailLoading && previewOrder != null) {
              return _buildContent(context, previewOrder!);
            }
            if (state is OrderDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrderDetailFailure) {
              return ProfileErrorState(
                message: state.errMessage,
                onRetry: () => context.read<OrderDetailCubit>().loadOrder(
                  orderId,
                  currentUserId: currentUserId,
                ),
                retryLabel: context.l10n.retryLabel,
              );
            }
            if (state is OrderDetailLoaded) {
              return _buildContent(context, state.order);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, RentalOrderEntity order) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderProductCard(order: order),
          HeightSpace(16),
          OrderSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderSectionHeader(title: context.l10n.rentalPeriod),
                HeightSpace(16),
                OrderInfoRow(
                  icon: Icons.person_outline_rounded,
                  label: context.l10n.ownerLabel,
                  value: order.ownerName,
                ),
                HeightSpace(12),
                OrderInfoRow(
                  icon: Icons.person,
                  label: context.l10n.renterLabel,
                  value: order.renterName,
                ),
                HeightSpace(12),
                OrderInfoRow(
                  icon: Icons.calendar_today_rounded,
                  label: context.l10n.rentalPeriod,
                  value:
                      '${_formatDate(order.startDate)} - ${_formatDate(order.endDate)}',
                ),
                HeightSpace(12),
                OrderInfoRow(
                  icon: Icons.date_range_rounded,
                  label: context.l10n.dayLabel,
                  value:
                      '${order.endDate.difference(order.startDate).inDays.clamp(1, 9999)} ${context.l10n.dayLabel}',
                ),
              ],
            ),
          ),
          HeightSpace(16),
          OrderSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderSectionHeader(title: context.l10n.pricingSummary),
                HeightSpace(16),
                OrderPriceRow(
                  label: context.l10n.rentalPriceLabel,
                  amount: order.rentalPrice,
                ),
                OrderPriceRow(
                  label: context.l10n.insurancePriceLabel,
                  amount: order.insurancePrice,
                ),
                OrderPriceRow(
                  label: context.l10n.serviceFeeLabel,
                  amount: order.serviceFee,
                ),
                HeightSpace(8),
                Divider(height: 1.h, color: AppColors.borderColor),
                HeightSpace(8),
                OrderPriceRow(
                  label: context.l10n.orderTotal,
                  amount: order.totalPrice,
                  isTotal: true,
                ),
              ],
            ),
          ),
          HeightSpace(16),
          OrderSectionContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderSectionHeader(title: context.l10n.deliveryDetails),
                HeightSpace(16),
                OrderInfoRow(
                  icon: Icons.local_shipping_outlined,
                  label: context.l10n.deliveryMethodLabel,
                  value: order.deliveryMethod.isNotEmpty
                      ? order.deliveryMethod
                      : '---',
                ),
                if (order.street.isNotEmpty ||
                    order.city.isNotEmpty ||
                    order.governorate.isNotEmpty) ...[
                  HeightSpace(12),
                  OrderInfoRow(
                    icon: Icons.location_on_outlined,
                    label: context.l10n.streetAddress,
                    value: order.street,
                  ),
                  if (order.city.isNotEmpty) ...[
                    HeightSpace(12),
                    OrderInfoRow(
                      icon: Icons.location_city_rounded,
                      label: context.l10n.city,
                      value: '${order.city}, ${order.governorate}',
                    ),
                  ],
                ],
              ],
            ),
          ),
          HeightSpace(16),
          OrderTimelineWidget(
            steps: OrderTimelineStep.fromOrderStatus(order.status, context),
          ),
          HeightSpace(16),
          if (currentUserId.isNotEmpty)
            OrderActionButtons(
              order: order,
              currentUserId: currentUserId,
              onActionSuccess: () {},
            ),
          HeightSpace(32),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}
