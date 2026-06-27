import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/my_products/domain/entities/product_transaction_entity.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_cubit.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_state.dart';

class ProductTransactionsScreen extends StatefulWidget {
  final int productId;

  const ProductTransactionsScreen({super.key, required this.productId});

  @override
  State<ProductTransactionsScreen> createState() =>
      _ProductTransactionsScreenState();
}

class _ProductTransactionsScreenState extends State<ProductTransactionsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<OwnerStatsCubit>().loadProductTransactions(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerStatsCubit, OwnerStatsState>(
      builder: (context, state) {
        if (state.isTransactionsLoading && state.transactions.isEmpty) {
          return const Scaffold(body: LoadingWidget());
        }

        return Scaffold(
          backgroundColor: const Color(0xffF7F8FC),
          appBar: AppBar(title: const Text('المعاملات')),
          body: RefreshIndicator(
            onRefresh: () => context
                .read<OwnerStatsCubit>()
                .loadProductTransactions(widget.productId),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              children: [
                if (state.errorMessage.isNotEmpty) ...[
                  Text(
                    state.errorMessage,
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  verticalSpacing(12),
                ],
                if (state.transactions.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 120),
                    child: Center(child: Text('لا توجد معاملات بعد')),
                  )
                else
                  ...state.transactions.map(
                    (transaction) => _TransactionCard(transaction: transaction),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TransactionCard extends StatelessWidget {
  final ProductTransactionEntity transaction;

  const _TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            transaction.renterName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppStyles.titleMedium.copyWith(fontWeight: FontWeight.w700),
          ),
          verticalSpacing(6),
          Text(
            'من ${_format(transaction.startDate)} إلى ${_format(transaction.endDate)}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpacing(6),
          Text(
            'السعر: ج.م ${transaction.totalPrice.toStringAsFixed(0)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpacing(6),
          Text(
            'الحالة: ${transaction.status}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  String _format(DateTime value) =>
      '${value.day.toString().padLeft(2, '0')}/${value.month.toString().padLeft(2, '0')}/${value.year}';
}
