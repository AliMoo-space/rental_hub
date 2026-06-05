import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_action_buttons_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_description_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_header_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_info_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/reviews_widget.dart';
import 'package:rental_hub/feature/chat/presentation/models/chat_route_args.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/seller_profile_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final void Function()? onBookNow;
  final void Function()? onChat;
  final void Function()? onReview;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    this.onBookNow,
    this.onChat,
    this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        title: Text(context.l10n.searchRentals, style: AppStyles.titleMedium),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HEADER
            ProductHeaderWidget(product: product),

            ProductInfoWidget(product: product),
            verticalSpacing(8),
            Divider(color: AppColors.borderColor, height: 1),

            SellerProfileWidget(product: product),
            verticalSpacing(12),

            /// DESCRIPTION
            ProductDescriptionWidget(product: product, maxLines: 3),

            verticalSpacing(24),

            ReviewsWidget(
              product: product,
              onViewAllReviews: () {
                context.pushNamed(
                  AppRoutes.productReviewsScreen,
                  pathParameters: {'productId': product.id.toString()},
                );
              },
            ),
            verticalSpacing(32),

            /// ACTION BUTTONS
            ProductActionButtonsWidget(
              onChat: onChat ?? () => _openSellerChat(context),
              onReview:
                  onReview ??
                  () {
                    context.pushNamed(
                      AppRoutes.productReviewsScreen,
                      pathParameters: {'productId': product.id.toString()},
                    );
                  },
              onBookNow:
                  onBookNow ??
                  () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Booking flow will open here.'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
            ),

            verticalSpacing(16),
          ],
        ),
      ),
    );
  }

  void _openSellerChat(BuildContext context) {
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
}
