import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/app_image.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/my_products_cubit.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/my_products_state.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({super.key});

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<MyProductsCubit>().loadMyProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyProductsCubit, MyProductsState>(
      builder: (context, state) {
        final cubit = context.read<MyProductsCubit>();
        final hasItems = cubit.pagingController.items?.isNotEmpty ?? false;

        return Scaffold(
          backgroundColor: const Color(0xffF7F8FC),
          appBar: AppBar(
            title: Text(
              'قائمة منتجاتي',
              style: AppStyles.hendi500Size20,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  context.pushNamed(AppRoutes.ownerStatsScreen);
                },
                icon: const Icon(Icons.insights_outlined),
              ),
            ],
          ),
          body: state is MyProductsLoading && !hasItems
              ? const LoadingWidget()
              : RefreshIndicator(
                  onRefresh: cubit.loadMyProducts,
                  child: PagedListView<int, ProductEntity>(
                    state: cubit.pagingController.value,
                    fetchNextPage: cubit.pagingController.fetchNextPage,
                    builderDelegate:
                        PagedChildBuilderDelegate<ProductEntity>(
                      itemBuilder: (context, product, index) {
                        return _MyProductCard(
                          product: product,
                          onEdit: () => _openEdit(context, product),
                          onStats: () => _openProductStats(context, product),
                          onTransactions: () =>
                              _openTransactions(context, product),
                          onRequests: () => _openRequests(context, product),
                          onDelete: () => _deleteProduct(context, product),
                          onToggleStatus: () => _toggleStatus(context, product),
                        );
                      },
                      firstPageErrorIndicatorBuilder: (context) => _ErrorView(
                        message: state is MyProductsError
                            ? state.message
                            : 'تعذر تحميل المنتجات',
                        onRetry: cubit.loadMyProducts,
                      ),
                      noItemsFoundIndicatorBuilder: (context) => _EmptyView(
                        onRefresh: cubit.loadMyProducts,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }

  Future<void> _deleteProduct(BuildContext context, ProductEntity product) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف المنتج'),
        content: Text('هل تريد حذف "${product.name}"؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('حذف'),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    final result = await context.read<MyProductsCubit>().deleteProduct(id: product.id);
    if (!context.mounted) return;

    result.fold(
      (failure) => showMsg(failure.errMessage, context),
      (message) => showMsg(message, context),
    );
  }

  Future<void> _toggleStatus(BuildContext context, ProductEntity product) async {
    final cubit = context.read<MyProductsCubit>();
    final isSuspended = _isSuspended(product.status);
    final result = isSuspended
        ? await cubit.activateProduct(id: product.id)
        : await cubit.suspendProduct(id: product.id);

    if (!context.mounted) return;
    result.fold(
      (failure) => showMsg(failure.errMessage, context),
      (message) => showMsg(message, context),
    );
  }

  void _openEdit(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.addListingScreen,
      extra: product,
    );
  }

  void _openProductStats(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.productStatsScreen,
      pathParameters: {'productId': product.id.toString()},
    );
  }

  void _openTransactions(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.productTransactionsScreen,
      pathParameters: {'productId': product.id.toString()},
    );
  }

  void _openRequests(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.productRentalRequestsScreen,
      pathParameters: {'productId': product.id.toString()},
    );
  }

  bool _isSuspended(String status) {
    final normalized = status.toLowerCase();
    return normalized.contains('suspend') ||
        normalized.contains('inactive') ||
        normalized.contains('pause');
  }
}

class _MyProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onEdit;
  final VoidCallback onStats;
  final VoidCallback onTransactions;
  final VoidCallback onRequests;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;

  const _MyProductCard({
    required this.product,
    required this.onEdit,
    required this.onStats,
    required this.onTransactions,
    required this.onRequests,
    required this.onDelete,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isSuspended = product.status.toLowerCase().contains('suspend');

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: AppNetworkImage(
                images: product.images,
                width: 96.w,
                height: 96.w,
                fit: BoxFit.cover,
              ),
            ),
            horizontalSpacing(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 36.w,
                        height: 36.w,
                        child: PopupMenuButton<_MyProductAction>(
                          padding: EdgeInsets.zero,
                          iconSize: 20.sp,
                          onSelected: (action) {
                            switch (action) {
                              case _MyProductAction.edit:
                                onEdit();
                                break;
                              case _MyProductAction.stats:
                                onStats();
                                break;
                              case _MyProductAction.transactions:
                                onTransactions();
                                break;
                              case _MyProductAction.requests:
                                onRequests();
                                break;
                              case _MyProductAction.toggleStatus:
                                onToggleStatus();
                                break;
                              case _MyProductAction.delete:
                                onDelete();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: _MyProductAction.edit,
                              child: Text('تعديل'),
                            ),
                            const PopupMenuItem(
                              value: _MyProductAction.stats,
                              child: Text('الإحصائيات'),
                            ),
                            const PopupMenuItem(
                              value: _MyProductAction.transactions,
                              child: Text('المعاملات'),
                            ),
                            const PopupMenuItem(
                              value: _MyProductAction.requests,
                              child: Text('طلبات الإيجار'),
                            ),
                            PopupMenuItem(
                              value: _MyProductAction.toggleStatus,
                              child: Text(isSuspended ? 'تفعيل' : 'إيقاف'),
                            ),
                            const PopupMenuItem(
                              value: _MyProductAction.delete,
                              child: Text('حذف'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  verticalSpacing(4),
                  Text(
                    product.categoryName.isEmpty
                        ? product.subcategoryName
                        : product.categoryName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  verticalSpacing(8),
                  Text(
                    product.locationArea,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryColor,
                    ),
                  ),
                  verticalSpacing(8),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 260;

                      final priceText = Text(
                        'ج.م ${product.finalPricePerDay.toString()} / يوم',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyles.bodyMedium.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w700,
                        ),
                      );

                      if (isNarrow) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _StatusChip(status: product.status),
                            verticalSpacing(6),
                            priceText,
                          ],
                        );
                      }

                      return Row(
                        children: [
                          Flexible(child: _StatusChip(status: product.status)),
                          horizontalSpacing(8),
                          Expanded(child: priceText),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final isSuspended = status.toLowerCase().contains('suspend');
    final backgroundColor = isSuspended
        ? AppColors.primaryColor.withValues(alpha: 0.12)
        : AppColors.successColor.withValues(alpha: 0.12);
    final textColor = isSuspended ? AppColors.primaryColor : AppColors.successColor;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Text(
        status.isEmpty ? 'نشط' : status,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppStyles.bodySmall.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, textAlign: TextAlign.center),
            verticalSpacing(16),
            PrimaryButtonWidget(
              buttonText: 'إعادة المحاولة',
              width: 180.w,
              height: 44.h,
              onPress: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _EmptyView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        SizedBox(height: 0.35.sh),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'لا توجد منتجات حتى الآن',
                style: AppStyles.titleMedium,
              ),
              verticalSpacing(12),
              PrimaryButtonWidget(
                buttonText: 'تحديث',
                width: 150.w,
                height: 44.h,
                onPress: onRefresh,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum _MyProductAction { edit, stats, transactions, requests, toggleStatus, delete }
