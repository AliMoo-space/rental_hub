import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/home/domain/entities/product_entity.dart';
import 'package:rental_hub/feature/search/domain/entities/live_suggestion_entity.dart';
import 'package:rental_hub/feature/search/domain/entities/search_result_entity.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_cubit.dart';
import 'package:rental_hub/feature/search/presentation/cubit/search_state.dart';
import 'package:rental_hub/feature/search/presentation/widgets/live_suggestions_dropdown.dart';
import 'package:rental_hub/feature/search/presentation/widgets/search_bar_widget.dart';
import 'package:rental_hub/feature/search/presentation/widgets/search_filter_chips.dart';
import 'package:rental_hub/feature/search/presentation/widgets/search_loading_shimmer.dart';
import 'package:rental_hub/feature/search/presentation/widgets/search_result_card.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if ((widget.initialQuery ?? '').isNotEmpty) {
      controller.text = widget.initialQuery!;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (controller.text.isNotEmpty) {
        context.read<SearchCubit>().onQueryChanged(controller.text);
      } else {
        context.read<SearchCubit>().loadRecommendations();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'البحث',
          style: AppStyles.titleMedium.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFF8FAFF), Color(0xFFF7F8F9)],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: SearchBarWidget(
                  controller: controller,
                  onSubmit: () => context.read<SearchCubit>().submitSearch(),
                ),
              ),
            ),
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                if (state is LiveSearchLoading) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 26,
                            offset: const Offset(0, 12),
                          ),
                        ],
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: const SearchSuggestionsShimmer(),
                    ),
                  );
                }

                if (state is LiveSearchLoaded) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 26,
                            offset: const Offset(0, 12),
                          ),
                        ],
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: LiveSuggestionsDropdown(
                        suggestions: state.suggestions,
                        onTap: (suggestion) {
                          _openSuggestionDetails(context, suggestion);
                        },
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const SearchLoadingShimmer();
                    }

                    if (state is SearchLoadingMore) {
                      return const SearchLoadingShimmer(showMoreTile: true);
                    }

                    if (state is SearchEmpty) {
                      return _EmptyState(
                        onReset: () {
                          controller.clear();
                          context.read<SearchCubit>().onQueryChanged('');
                        },
                      );
                    }

                    if (state is SearchError) {
                      return _ErrorState(
                        message: state.message,
                        onRetry: () =>
                            context.read<SearchCubit>().submitSearch(),
                      );
                    }

                    if (state is SearchLoaded) {
                      final items = state.results.items;
                      return NotificationListener<ScrollNotification>(
                        onNotification: (scroll) {
                          if (scroll.metrics.pixels >=
                              scroll.metrics.maxScrollExtent - 200) {
                            context.read<SearchCubit>().loadMore();
                          }
                          return false;
                        },
                        child: GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 12.w,
                                mainAxisSpacing: 12.h,
                                childAspectRatio: 0.72,
                              ),
                          itemCount: items.length + (state.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= items.length) {
                              return const _LoadMoreTile();
                            }
                            final item = items[index];
                            return SearchResultCard(
                              item: item,
                              onTap: () =>
                                  _openSearchResultDetails(context, item),
                              onFavoritePressed: () =>
                                  context
                                      .read<SearchCubit>()
                                      .toggleFavorite(item.id),
                              isFavoriteLoading:
                                  state.isFavoriteLoading(item.id),
                            );
                          },
                        ),
                      );
                    }

                    return const SearchLoadingShimmer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _openSearchResultDetails(BuildContext context, ProductItemEntity item) {
  final product = _buildProductEntity(
    id: item.id,
    name: item.name,
    categoryName: item.category,
    locationArea: item.location,
    condition: item.condition,
    basePricePerDay: item.basePricePerDay,
    finalPricePerDay: item.basePricePerDay,
    images: item.images,
    averageRating: item.rating,
    isFavorite: item.isFavorite,
  );

  context.pushNamed(
    AppRoutes.productDetailsScreen,
    pathParameters: AppRoutes.productDetailsPathParameters(item.id),
    extra: product,
  );
}

void _openSuggestionDetails(BuildContext context, LiveSuggestionEntity item) {
  final product = _buildProductEntity(
    id: item.id,
    name: item.name,
    categoryName: item.category,
    locationArea: item.location,
    condition: item.condition,
    basePricePerDay: item.pricePerDay,
    finalPricePerDay: item.pricePerDay,
    images: item.imageUrl == null ? const [] : [item.imageUrl!],
    averageRating: 0,
  );

  context.pushNamed(
    AppRoutes.productDetailsScreen,
    pathParameters: AppRoutes.productDetailsPathParameters(item.id),
    extra: product,
  );
}

ProductEntity _buildProductEntity({
  required int id,
  required String name,
  required String categoryName,
  required String locationArea,
  required String condition,
  required num basePricePerDay,
  required num finalPricePerDay,
  required List<String> images,
  required double averageRating,
  bool isFavorite = false,
}) {
  return ProductEntity(
    id: id,
    userId: '',
    userFullName: '',
    categoryId: 0,
    categoryName: categoryName,
    subcategoryId: 0,
    subcategoryName: '',
    locationArea: locationArea,
    condition: condition,
    productType: '',
    brand: '',
    rentalGuarantee: '',
    name: name,
    description: '',
    basePricePerDay: basePricePerDay,
    finalPricePerDay: finalPricePerDay,
    commissionPercentage: 0,
    termsConditions: '',
    status: '',
    createdAt: DateTime.now(),
    averageRating: averageRating,
    totalReviews: 0,
    totalRentalCount: 0,
    totalPlatformProfit: 0,
    images: images,
    isFavorite: isFavorite,
  );
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: 34.sp,
              color: AppColors.errorColor,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('إعادة المحاولة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final VoidCallback onReset;

  const _EmptyState({required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 34.sp,
              color: AppColors.textSecondary,
            ),
            SizedBox(height: 12.h),
            Text(
              'لا توجد نتائج مطابقة',
              style: AppStyles.titleMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'جرّب كلمة مختلفة أو استخدم فلاتر أخرى للوصول لنتائج أفضل.',
              textAlign: TextAlign.center,
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 16.h),
            TextButton(onPressed: onReset, child: const Text('مسح البحث')),
          ],
        ),
      ),
    );
  }
}

class _LoadMoreTile extends StatelessWidget {
  const _LoadMoreTile();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
