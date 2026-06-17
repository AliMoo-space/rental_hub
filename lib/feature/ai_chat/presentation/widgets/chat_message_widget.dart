import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/feature/ai_chat/presentation/models/chat_message_model.dart';
import 'package:rental_hub/feature/ai_chat/presentation/widgets/product_card.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';

class ChatMessageWidget extends StatelessWidget {
  final ChatMessageModel message;

  const ChatMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.h),
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        child: Column(
          crossAxisAlignment: message.isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // If preview products exist, render product cards like the screenshot
            if (message.products.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: message.products
                      .map(
                        (p) => ProductCard(
                          product: p,
                          onTap: () => context.pushNamed(
                            AppRoutes.productDetailsScreen,
                            pathParameters:
                                AppRoutes.productDetailsPathParameters(p.id),
                            extra: ProductEntity(
                              id: p.id,
                              userId: '',
                              userFullName: '',
                              categoryId: 0,
                              categoryName: '',
                              subcategoryId: 0,
                              subcategoryName: '',
                              locationArea: p.location,
                              condition: p.condition,
                              productType: '',
                              brand: '',
                              rentalGuarantee: '',
                              name: p.name,
                              description: '',
                              basePricePerDay: p.pricePerDay,
                              finalPricePerDay: p.pricePerDay,
                              commissionPercentage: 0,
                              termsConditions: '',
                              status: '',
                              createdAt: DateTime.now(),
                              averageRating: 0.0,
                              totalReviews: 0,
                              totalRentalCount: 0,
                              totalPlatformProfit: 0,
                              images:
                                  p.imageUrl != null ? [p.imageUrl!] : const [],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 8.h),
            ] else
            // Display images if they exist
            if (message.imageUrls.isNotEmpty) ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    message.imageUrls.length,
                    (index) => Container(
                      margin: EdgeInsets.only(right: 8.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: message.isUser ? Colors.blue : Colors.grey,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(
                          message.imageUrls[index],
                          width: 120.w,
                          height: 120.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: const Icon(Icons.image_not_supported),
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: 120.w,
                              height: 120.w,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
            ],
            // Display text message
            if (message.text.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: message.isUser ? Colors.blue : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  message.text,
                  style: TextStyle(
                    color: message.isUser ? Colors.white : Colors.black87,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                _formatTime(message.timestamp),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat('h:mm a', 'en').format(dateTime);
  }
}
