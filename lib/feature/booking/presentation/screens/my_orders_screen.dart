import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/my_orders_cubit.dart';
import 'package:rental_hub/feature/booking/presentation/cubit/my_orders_state.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<MyOrdersCubit>()..loadMyOrders(refresh: true),
      child: Scaffold(
        appBar: AppBar(
          title: Text('طلباتي', style: AppStyles.titleMedium),
        ),
        body: BlocBuilder<MyOrdersCubit, MyOrdersState>(
          builder: (context, state) {
            if (state is MyOrdersLoading && state.isFirstFetch) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MyOrdersFailure) {
              return Center(child: Text(state.errMessage));
            } else if (state is MyOrdersLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('لا توجد طلبات'));
              }
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return ListTile(
                    title: Text(order.productName.isNotEmpty ? order.productName : 'منتج #${order.productId}'),
                    subtitle: Text('الحالة: ${order.status}'),
                    trailing: Text('${order.totalPrice} ج.م'),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
