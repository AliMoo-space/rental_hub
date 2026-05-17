import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_action_buttons_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_description_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_header_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/product_info_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/reviews_widget.dart';
import 'package:rental_hub/feature/product_details/presentation/widgets/seller_profile_widget.dart';

class ProductDetailsScreen extends StatelessWidget {
  final void Function()? onBookNow;
  final void Function()? onChat;
  final void Function()? onReview;

  const ProductDetailsScreen({
    super.key,
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
      body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return const LoadingWidget();
          }

          if (state is ProductDetailsError) {
            return Center(child: Text(state.message));
          }

          if (state is ProductDetailsLoaded) {
            final product = state.productDetails;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  ProductHeaderWidget(productDetails: product),

                  ProductInfoWidget(productDetails: product),
                  verticalSpacing(8),
                  Divider(color: AppColors.borderColor, height: 1),

                  SellerProfileWidget(productDetails: product),
                  verticalSpacing(12),

                  /// DESCRIPTION
                  ProductDescriptionWidget(
                    productDetails: product,
                    maxLines: 3,
                  ),

                  verticalSpacing(24),

                  ReviewsWidget(
                    onViewAllReviews: () {
                      // TODO: navigate to reviews screen
                    },
                  ),
                  verticalSpacing(32),

                  /// ACTION BUTTONS
                  ProductActionButtonsWidget(
                    onChat:
                        onChat ??
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Opening chat...'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                    onReview:
                        onReview ??
                        () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Opening review...'),
                              duration: Duration(seconds: 1),
                            ),
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
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:rental_hub/core/extensions/localization_extension.dart';
// import 'package:rental_hub/core/routing/app_routes.dart';
// import 'package:rental_hub/core/styling/app_colors.dart';
// import 'package:rental_hub/core/styling/app_styles.dart';
// import 'package:rental_hub/core/widgets/loading_widget.dart';
// import 'package:rental_hub/core/widgets/spacing_widgets.dart';
// import 'package:rental_hub/feature/product_details/presentation/cubit/product_details_cubit.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/product_action_buttons_widget.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/product_description_widget.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/product_header_widget.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/product_info_widget.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/reviews_widget.dart';
// import 'package:rental_hub/feature/product_details/presentation/widgets/seller_profile_widget.dart';

// class ProductDetailsScreen extends StatefulWidget {
//   final void Function()? onBookNow;
//   final void Function()? onChat;
//   final void Function()? onReview;

//   const ProductDetailsScreen({
//     super.key,
//     this.onBookNow,
//     this.onChat,
//     this.onReview,
//   });

//   @override
//   State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
// }

// class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  // Sample data - replace with actual data from bloc/provider
//   final String productName = 'Canon Camera';
//   final String productImage =
//       'https://via.placeholder.com/400x400?text=Canon+Camera';
//   final String location = 'Cairo, Egypt';
//   final double rating = 4.5;
//   final int reviewCount = 128;
//   final double rentalPrice = 150;
//   final String rentalPeriod = 'per day';

//   final String sellerName = 'Mohamed Hassan';
//   final String sellerImage = 'https://via.placeholder.com/100x100?text=Seller';
//   final double sellerRating = 4.5;
//   final String sellerLocation = 'Cairo, Egypt';

//   final String productDescription = '''
// يأتي مع مجموعة شاملة من المعدات الاحترافية بما فيها عدسات متعددة وحامل ثلاثي القوائم وبطاريات احتياطية. 
// كاميرا احترافية عالية الجودة مناسبة للمصورين المحترفين والهواة.
// الحالة ممتازة وجاهزة للاستخدام الفوري.
//   ''';

//   late List<Review> reviews;

//   @override
//   void initState() {
//     super.initState();
//     reviews = [
//       Review(
//         reviewerName: 'Sarah Mohammed',
//         reviewerImage: 'https://via.placeholder.com/100x100?text=Sarah',
//         rating: 4.5,
//         reviewText:
//             'جودة ممتازة جداً والخدمة رائعة. الكاميرا تعمل بكفاءة عالية وصاحب المتجر ودود جداً.',
//       ),
//       Review(
//         reviewerName: 'Ahmed Ali',
//         reviewerImage: 'https://via.placeholder.com/100x100?text=Ahmed',
//         rating: 5,
//         reviewText:
//             'تجربة رائعة! سأستأجر مرة أخرى بالتأكيد. المعدات بحالة ممتازة والتسليم سريع.',
//       ),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.surfaceColor,
//       appBar: AppBar(
//         title: Text(context.l10n.searchRentals, style: AppStyles.titleMedium),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
//               builder: (context, state) {
//                 if (state is ProductDetailsLoading) {
//                   return LoadingWidget();
//                 }
//                 if (state is ProductDetailsLoaded) {
//                   return ProductHeaderWidget(
//                     productDetails: state.productDetails,
//                   );
//                 }
//                 if (state is ProductDetailsError) {
//                   return Center(child: Text(state.message));
//                 }
//                 return const SizedBox.shrink();
//               },
//             ),  

//             // Product Info (Title + Price)
//             ProductInfoWidget(
//               productName: productName,
//               rentalPrice: rentalPrice,
//               rentalPeriod: rentalPeriod,
//             ),
//             verticalSpacing(8),
//             Divider(color: AppColors.borderColor, height: 1),

//             // Seller Profile
//             SellerProfileWidget(
//               sellerName: sellerName,
//               sellerRating: sellerRating,
//               sellerLocation: sellerLocation,
//               sellerImage: sellerImage,
//               isVerified: true,
//             ),
//             verticalSpacing(12),

//             // Product Description
//             ProductDescriptionWidget(
//               description: productDescription,
//               maxLines: 3,
//             ),
//             verticalSpacing(24),

//             // Reviews Section
//             ReviewsWidget(
//               reviews: reviews,
//               onViewAllReviews: () {
//                 // Navigate to all reviews
//               },
//             ),
//             verticalSpacing(32),

//             // Action Buttons
//             ProductActionButtonsWidget(
//               onChat:
//                   widget.onChat ??
//                   () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Opening chat...'),
//                         duration: Duration(seconds: 1),
//                       ),
//                     );
//                   },
//               onReview:
//                   widget.onReview ??
//                   () {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('Opening review...'),
//                         duration: Duration(seconds: 1),
//                       ),
//                     );
//                   },
//               onBookNow:
//                   widget.onBookNow ??
//                   () {
//                     context.pushNamed(AppRoutes.bookingFlowScreen);
//                   },
//             ),
//             verticalSpacing(16),
//           ],
//         ),
//       ),
//     );
//   }
// }