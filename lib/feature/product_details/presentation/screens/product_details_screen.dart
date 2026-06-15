import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/service_locator.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/chat/presentation/models/chat_route_args.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/my_products_cubit.dart';
import 'package:rental_hub/feature/product_details/domain/entities/product_details_entity.dart';
import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_action_buttons_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_description_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_header_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_info_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/reviews_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/seller_profile_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final ProductEntity? previewProduct;

  const ProductDetailsScreen({
    super.key,
    required this.productId,
    this.previewProduct,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String? _currentUserId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<ProductDetailsCubit>().fetchProductDetails(widget.productId);
      _loadCurrentUserId();
    });
  }

  Future<void> _loadCurrentUserId() async {
    final currentUserId = await getIt<TokenStorageHelper>().getCurrentUserId();
    if (!mounted) return;
    setState(() {
      _currentUserId = currentUserId;
    });
  }

  bool _isOwner(ProductEntity product) {
    final currentUserId = _currentUserId;
    return currentUserId != null &&
        currentUserId.isNotEmpty &&
        product.userId.isNotEmpty &&
        product.userId == currentUserId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        if (state is ProductDetailsLoading && widget.previewProduct == null) {
          return const Scaffold(body: LoadingWidget());
        }

        if (state is ProductDetailsError) {
          return Scaffold(
            backgroundColor: AppColors.surfaceColor,
            appBar: AppBar(title: Text(context.l10n.searchRentals)),
            body: _ErrorState(
              message: state.message,
              onRetry: () =>
                  context.read<ProductDetailsCubit>().fetchProductDetails(
                        widget.productId,
                      ),
            ),
          );
        }

        final details = state is ProductDetailsLoaded ? state.productDetails : null;
        final product = details != null
            ? _toProductEntity(details)
            : widget.previewProduct;

        if (product == null) {
          return const Scaffold(body: LoadingWidget());
        }

        return Scaffold(
          backgroundColor: AppColors.surfaceColor,
          appBar: AppBar(
            title: Text(
              product.name.isEmpty ? context.l10n.searchRentals : product.name,
              style: AppStyles.titleMedium,
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is ProductDetailsLoading)
                      const LinearProgressIndicator(minHeight: 2),
                    ProductHeaderWidget(product: product),
                    ProductInfoWidget(product: product),
                    verticalSpacing(8),
                    Divider(color: AppColors.borderColor, height: 1),
                    SellerProfileWidget(product: product),
                    verticalSpacing(12),
                    ProductDescriptionWidget(product: product, maxLines: 3),
                    verticalSpacing(20),
                    if (_isOwner(product))
                      _OwnerActionsSection(
                        isSuspended: _isSuspended(product.status),
                        onEdit: () => _openEdit(context, product),
                        onDelete: () => _deleteProduct(context, product),
                        onToggleStatus: () =>
                            _toggleStatus(context, product, details?.id ?? product.id),
                        onStats: () => _openProductStats(context, product),
                        onTransactions: () => _openTransactions(context, product),
                        onRequests: () => _openRequests(context, product),
                      )
                    else
                      ProductActionButtonsWidget(
                        onChat: () => _openSellerChat(context, product),
                        onReview: () => _openReviews(context, product),
                        onBookNow: () async {
                          final dto = await context.pushNamed(AppRoutes.bookingFlowScreen, extra: product);
                          if (dto != null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('تم الحجز بنجاح!')),
                              );
                            }
                          }
                        },
                      ),
                    verticalSpacing(24),
                    ReviewsWidget(
                      product: product,
                      onViewAllReviews: () => _openReviews(context, product),
                    ),
                    verticalSpacing(32),
                  ],
                ),
              ),
            ],
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
      (failure) => showMsg(failure.errMessage, context, isError: true),
      (message) {
        showMsg(message, context);
        context.goNamed(AppRoutes.myProductsScreen);
      },
    );
  }

  Future<void> _toggleStatus(
    BuildContext context,
    ProductEntity product,
    int productId,
  ) async {
    final cubit = context.read<MyProductsCubit>();
    final result = _isSuspended(product.status)
        ? await cubit.activateProduct(id: product.id)
        : await cubit.suspendProduct(id: product.id);

    if (!context.mounted) return;

    result.fold(
      (failure) => showMsg(failure.errMessage, context, isError: true),
      (message) {
        showMsg(message, context);
        context.read<ProductDetailsCubit>().fetchProductDetails(productId);
      },
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

  void _openReviews(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.productReviewsScreen,
      pathParameters: {'productId': product.id.toString()},
    );
  }

  void _openSellerChat(BuildContext context, ProductEntity product) {
    context.pushNamed(
      AppRoutes.chatScreen,
      extra: ChatRouteArgs(
        sellerId: product.userId,
        sellerName: product.userFullName,
        productId: product.id,
        productName: product.name,
      ),
    );
  }

  bool _isSuspended(String status) {
    final normalized = status.toLowerCase();
    return normalized.contains('suspend') ||
        normalized.contains('inactive') ||
        normalized.contains('pause');
  }

  ProductEntity _toProductEntity(ProductDetailsEntity details) {
    return ProductEntity(
      id: details.id,
      userId: details.ownerId,
      userFullName: details.ownerName,
      categoryId: details.categoryId,
      categoryName: details.categoryName,
      subcategoryId: details.subcategoryId,
      subcategoryName: details.subcategoryName,
      locationArea: details.locationArea,
      condition: details.condition,
      productType: details.productType,
      brand: details.brand,
      rentalGuarantee: details.rentalGuarantee,
      name: details.name,
      description: details.description,
      basePricePerDay: details.basePricePerDay,
      finalPricePerDay: details.finalPricePerDay,
      commissionPercentage: details.commissionPercentage,
      termsConditions: details.termsConditions,
      status: details.status,
      createdAt: details.createdAt,
      averageRating: details.averageRating,
      totalReviews: details.totalReviews,
      totalRentalCount: details.totalRentalCount,
      totalPlatformProfit: details.totalPlatformProfit,
      images: details.images,
    );
  }
}

class _OwnerActionsSection extends StatelessWidget {
  final bool isSuspended;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;
  final VoidCallback onStats;
  final VoidCallback onTransactions;
  final VoidCallback onRequests;

  const _OwnerActionsSection({
    required this.isSuspended,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
    required this.onStats,
    required this.onTransactions,
    required this.onRequests,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final availableWidth = constraints.maxWidth;
          final singleColumn = availableWidth < 360;
          final buttonWidth = singleColumn
              ? double.infinity
              : (availableWidth - 12.w) / 2;

          Widget buildActionButton({
            required Widget child,
          }) {
            return SizedBox(
              width: buttonWidth,
              child: child,
            );
          }

          final actions = [
            buildActionButton(
              child: PrimaryButtonWidget(
                buttonText: 'تعديل',
                height: 48.h,
                onPress: onEdit,
              ),
            ),
            buildActionButton(
              child: PrimaryButtonWidget(
                buttonText: isSuspended ? 'تفعيل' : 'إيقاف',
                height: 48.h,
                buttonColor: isSuspended
                    ? AppColors.successColor
                    : AppColors.primaryColor,
                onPress: onToggleStatus,
              ),
            ),
            buildActionButton(
              child: OutlinedButton(
                onPressed: onStats,
                child: const Text('الإحصائيات'),
              ),
            ),
            buildActionButton(
              child: OutlinedButton(
                onPressed: onTransactions,
                child: const Text('المعاملات'),
              ),
            ),
            buildActionButton(
              child: OutlinedButton(
                onPressed: onRequests,
                child: const Text('الطلبات'),
              ),
            ),
            buildActionButton(
              child: OutlinedButton(
                onPressed: onDelete,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.primaryColor),
                ),
                child: const Text('حذف'),
              ),
            ),
          ];

          if (singleColumn) {
            return Column(
              children: actions
                  .map((action) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: action,
                      ))
                  .toList(),
            );
          }

          return Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: actions,
          );
        },
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.bodyLarge,
            ),
            verticalSpacing(16),
            PrimaryButtonWidget(
              buttonText: 'إعادة المحاولة',
              width: 180.w,
              height: 46.h,
              onPress: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
