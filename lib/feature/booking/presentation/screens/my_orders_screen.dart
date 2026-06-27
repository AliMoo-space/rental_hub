import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/my_orders_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/my_orders_state.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_card_widget.dart';
import 'package:rental_hub/feature/booking/presentation/widgets/order_empty_state.dart';

import 'package:rental_hub/feature/booking/presentation/widgets/order_skeleton_loader.dart';
import 'package:rental_hub/feature/profile/presentation/widgets/profile_error_state.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyOrdersCubit>()..loadMyOrders(refresh: true),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(context.l10n.myOrders, style: AppStyles.hendi500Size20),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<MyOrdersCubit, MyOrdersState>(
                builder: (context, state) {
                  if (state is MyOrdersLoading && state.isFirstFetch) {
                    return const OrderSkeletonLoader();
                  }
                  if (state is MyOrdersFailure) {
                    return ProfileErrorState(
                      message: state.errMessage,
                      onRetry: () => context.read<MyOrdersCubit>().loadMyOrders(
                        refresh: true,
                      ),
                      retryLabel: context.l10n.retryLabel,
                    );
                  }
                  if (state is MyOrdersLoaded) {
                    if (state.orders.isEmpty) {
                      return OrderEmptyState(
                        type: _searchController.text.isNotEmpty
                            ? OrderEmptyType.searchResults
                            : OrderEmptyType.noOrders,
                        searchQuery: _searchController.text,
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: () => context
                          .read<MyOrdersCubit>()
                          .loadMyOrders(refresh: true),
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (notification) {
                          if (notification is ScrollEndNotification &&
                              notification.metrics.pixels >=
                                  notification.metrics.maxScrollExtent -
                                      100.h &&
                              !state.hasReachedMax) {
                            context.read<MyOrdersCubit>().loadMyOrders();
                          }
                          return false;
                        },
                        child: ListView.separated(
                          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                          itemCount: state.orders.length,
                          separatorBuilder: (_, __) => HeightSpace(12),
                          itemBuilder: (context, index) {
                            final order = state.orders[index];
                            return OrderCardWidget(
                              order: order,
                              onTap: () => context.push(
                                AppRoutes.orderDetailLocation(order.id),
                                extra: order,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
