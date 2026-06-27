import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/core/widgets/filter_header_widget.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/create_community_post_card.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_request_card.dart';
import 'package:rental_hub/feature/community/presentation/widgets/submit_community_offer_sheet.dart';

class CommunityFeedTab extends StatefulWidget {
  final TextEditingController searchController;

  const CommunityFeedTab({super.key, required this.searchController});

  @override
  State<CommunityFeedTab> createState() => _CommunityFeedTabState();
}

class _CommunityFeedTabState extends State<CommunityFeedTab> {
  Timer? _debounceTimer;

  void _onSearchTap() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 400), () {
      context.read<CommunityRequestsCubit>().searchRequests(
        widget.searchController.text,
      );
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () =>
          context.read<CommunityRequestsCubit>().loadRequests(refresh: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 18.w,
          vertical: 20.h,
        ),
        child: Column(
          children: [
            const CreateCommunityPostCard(),
            SizedBox(height: 14.h),
            FilterHeaderWidget(
              title: 'عروض المجتمع',
              selectedFilter: context.l10n.community,
              onSearchTap: _onSearchTap,
              onFilterTap: () {
                showMsg('قريباً...', context);
              },
            ),
            SizedBox(height: 14.h),
            BlocBuilder<CommunityRequestsCubit, CommunityRequestsState>(
              builder: (context, state) {
                if (state.isLoading && state.requests.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: const Center(child: CircularProgressIndicator()),
                  );
                }

                if (state.errorMessage != null && state.requests.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 48.sp,
                          color: AppColors.smallSecondaryColor,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          state.errorMessage!,
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.smallSecondaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        TextButton.icon(
                          onPressed: () => context
                              .read<CommunityRequestsCubit>()
                              .loadRequests(refresh: true),
                          icon: const Icon(Icons.refresh),
                          label: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }

                if (state.requests.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48.sp,
                          color: AppColors.smallSecondaryColor,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'لا توجد طلبات حالياً',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.smallSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'كن أول من يضيف طلباً في المجتمع',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.smallSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    ...state.requests.map(
                      (request) => Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: CommunityRequestCard(
                          request: request,
                          onTap: () => context.push(
                            '${AppRoutes.communityRequestDetailsPath}/${request.id}',
                          ),
                          onSubmitOffer: () =>
                              showSubmitCommunityOfferSheet(context, request),
                        ),
                      ),
                    ),
                    if (state.hasNextPage)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: TextButton(
                          onPressed: state.isLoadingMore
                              ? null
                              : () => context
                                    .read<CommunityRequestsCubit>()
                                    .loadMoreRequests(),
                          child: state.isLoadingMore
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('تحميل المزيد'),
                        ),
                      ),
                    if (state.isLoadingMore)
                      Padding(
                        padding: EdgeInsets.only(top: 8.h),
                        child: const Center(child: CircularProgressIndicator()),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
