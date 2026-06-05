import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_shadows.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/filter_header_widget.dart';
import 'package:rental_hub/feature/community/domain/entities/community_offer_entity.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_time_label.dart';
import 'package:rental_hub/feature/community/presentation/widgets/create_community_request_sheet.dart';
import 'package:rental_hub/feature/community/presentation/widgets/submit_community_offer_sheet.dart';
import 'package:rental_hub/feature/home/presentation/widgets/home_header_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (!_tabController.indexIsChanging) return;
    if (_tabController.index == 1) {
      context.read<CommunityOffersCubit>().loadIncomingOffers();
    } else if (_tabController.index == 2) {
      context.read<CommunityOffersCubit>().loadMyOffers();
      context.read<CommunityRequestsCubit>().loadMyRequests();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _showFeedback(BuildContext context, String? message) {
    if (message == null || message.trim().isEmpty) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CommunityRequestsCubit, CommunityRequestsState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              previous.actionMessage != current.actionMessage,
          listener: (context, state) {
            _showFeedback(context, state.errorMessage);
            _showFeedback(context, state.actionMessage);
            context.read<CommunityRequestsCubit>().clearMessages();
          },
        ),
        BlocListener<CommunityOffersCubit, CommunityOffersState>(
          listenWhen: (previous, current) =>
              previous.errorMessage != current.errorMessage ||
              previous.actionMessage != current.actionMessage,
          listener: (context, state) {
            _showFeedback(context, state.errorMessage);
            _showFeedback(context, state.actionMessage);
            context.read<CommunityOffersCubit>().clearMessages();
          },
        ),
      ],
      child: Scaffold(
        appBar: HomeHeaderWidget(),
        body: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 600.w),
            child: Column(
              children: [
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.smallSecondaryColor,
                  indicatorColor: AppColors.primaryColor,
                  tabs: const [
                    Tab(text: 'المجتمع'),
                    Tab(text: 'عروض واردة'),
                    Tab(text: 'نشاطي'),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _CommunityFeedTab(searchController: _searchController),
                      const _IncomingOffersTab(),
                      const _MyActivityTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CommunityFeedTab extends StatelessWidget {
  const _CommunityFeedTab({required this.searchController});

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<CommunityRequestsCubit>().loadRequests(refresh: true),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsetsDirectional.symmetric(horizontal: 18.w, vertical: 20.h),
        child: Column(
          children: [
            _CreateCommunityPostCard(
              onTap: () => showCreateCommunityRequestSheet(context),
            ),
            SizedBox(height: 14.h),
            FilterHeaderWidget(
              title: 'عروض المجتمع',
              selectedFilter: context.l10n.community,
              onSearchTap: () {
                context.read<CommunityRequestsCubit>().searchRequests(
                  searchController.text,
                );
              },
              onFilterTap: () {},
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

                if (state.requests.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'لا توجد طلبات حالياً',
                      style: AppStyles.bodyMedium.copyWith(
                        color: AppColors.smallSecondaryColor,
                      ),
                    ),
                  );
                }

                return Column(
                  children: [
                    ...state.requests.map(
                      (request) => Padding(
                        padding: EdgeInsets.only(bottom: 14.h),
                        child: _CommunityRequestCard(
                          request: request,
                          onSubmitOffer: () =>
                              showSubmitCommunityOfferSheet(context, request),
                        ),
                      ),
                    ),
                    if (state.hasNextPage)
                      TextButton(
                        onPressed: state.isLoadingMore
                            ? null
                            : () => context
                                .read<CommunityRequestsCubit>()
                                .loadMoreRequests(),
                        child: state.isLoadingMore
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('تحميل المزيد'),
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

class _IncomingOffersTab extends StatelessWidget {
  const _IncomingOffersTab();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityOffersCubit, CommunityOffersState>(
      builder: (context, state) {
        if (state.isLoadingIncoming && state.incomingOffers.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.incomingOffers.isEmpty) {
          return Center(
            child: Text(
              'لا توجد عروض واردة',
              style: AppStyles.bodyMedium.copyWith(
                color: AppColors.smallSecondaryColor,
              ),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () =>
              context.read<CommunityOffersCubit>().loadIncomingOffers(),
          child: ListView.separated(
            padding: EdgeInsetsDirectional.all(18.w),
            itemCount: state.incomingOffers.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final offer = state.incomingOffers[index];
              return _IncomingOfferCard(
                offer: offer,
                isSubmitting: state.isSubmitting,
                onAccept: () =>
                    context.read<CommunityOffersCubit>().acceptOffer(offer.id),
                onReject: () =>
                    context.read<CommunityOffersCubit>().rejectOffer(offer.id),
              );
            },
          ),
        );
      },
    );
  }
}

class _MyActivityTab extends StatelessWidget {
  const _MyActivityTab();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          context.read<CommunityOffersCubit>().loadMyOffers(),
          context.read<CommunityRequestsCubit>().loadMyRequests(),
        ]);
      },
      child: ListView(
        padding: EdgeInsetsDirectional.all(18.w),
        children: [
          Text('طلباتي', style: AppStyles.hendi500Size20),
          SizedBox(height: 10.h),
          BlocBuilder<CommunityRequestsCubit, CommunityRequestsState>(
            builder: (context, state) {
              if (state.isLoadingMyRequests && state.myRequests.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.myRequests.isEmpty) {
                return Text(
                  'لا توجد طلبات',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.smallSecondaryColor,
                  ),
                );
              }
              return Column(
                children: state.myRequests
                    .map(
                      (request) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _CommunityRequestCard(
                          request: request,
                          showSubmitButton: false,
                        ),
                      ),
                    )
                    .toList(),
              );
            },
          ),
          SizedBox(height: 20.h),
          Text('عروضي', style: AppStyles.hendi500Size20),
          SizedBox(height: 10.h),
          BlocBuilder<CommunityOffersCubit, CommunityOffersState>(
            builder: (context, state) {
              if (state.isLoadingMyOffers && state.myOffers.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.myOffers.isEmpty) {
                return Text(
                  'لا توجد عروض',
                  style: AppStyles.bodyMedium.copyWith(
                    color: AppColors.smallSecondaryColor,
                  ),
                );
              }
              return Column(
                children: state.myOffers
                    .map(
                      (offer) => Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: _MyOfferCard(offer: offer),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CreateCommunityPostCard extends StatelessWidget {
  const _CreateCommunityPostCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsetsDirectional.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [AppShadows.softCard],
        ),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: AppColors.surfaceVariantColor,
                  child: Icon(
                    Icons.person,
                    size: 20.sp,
                    color: AppColors.smallSecondaryColor,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'هل تود إضافة طلب؟',
                  textAlign: TextAlign.end,
                  style: AppStyles.inputHint.copyWith(
                    color: AppColors.smallSecondaryColor,
                    fontSize: 15.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Divider(height: 1.h, color: AppColors.borderColor),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _PostActionChip(
                    label: 'صورة',
                    icon: Icons.image_outlined,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _PostActionChip(
                    label: 'حدد السعر',
                    icon: Icons.payments_outlined,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _PostActionChip(
                    label: 'مدة الإيجار',
                    icon: Icons.calendar_month_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PostActionChip extends StatelessWidget {
  const _PostActionChip({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: AppStyles.bodySmall.copyWith(
                color: AppColors.smallSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 11.sp,
              ),
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.smallSecondaryColor),
        ],
      ),
    );
  }
}

class _CommunityRequestCard extends StatelessWidget {
  const _CommunityRequestCard({
    required this.request,
    this.onSubmitOffer,
    this.showSubmitButton = true,
  });

  final CommunityRequestEntity request;
  final VoidCallback? onSubmitOffer;
  final bool showSubmitButton;

  @override
  Widget build(BuildContext context) {
    final displayName = request.userFullName.trim().isEmpty
        ? 'مستخدم'
        : request.userFullName;
    final body = request.description.trim().isEmpty
        ? request.title
        : request.description;

    return Container(
      width: double.infinity,
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28.r,
                backgroundColor: AppColors.surfaceVariantColor,
                backgroundImage: request.userImageUrl != null &&
                        request.userImageUrl!.isNotEmpty
                    ? NetworkImage(request.userImageUrl!)
                    : null,
                child: request.userImageUrl == null || request.userImageUrl!.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 20.sp,
                        color: AppColors.smallSecondaryColor,
                      )
                    : null,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  displayName,
                  textAlign: TextAlign.end,
                  style: AppStyles.hendi500Size20,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            body,
            textAlign: TextAlign.start,
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.smallSecondaryColor,
              height: 1.6,
            ),
          ),
          SizedBox(height: 14.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              if (request.locationLabel.isNotEmpty)
                _InfoTag(
                  icon: Icons.location_on_outlined,
                  text: request.locationLabel,
                ),
              _InfoTag(
                icon: Icons.access_time,
                text: communityTimeLabel(request.createdAt),
              ),
              if (request.budget > 0)
                _InfoTag(
                  icon: Icons.payments_outlined,
                  text: '${request.budget.toStringAsFixed(0)} ج.م',
                ),
            ],
          ),
          if (showSubmitButton) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSubmitOffer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                child: Text(
                  'تقديم عرض',
                  style: AppStyles.buttonLabel.copyWith(fontSize: 15.sp),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _IncomingOfferCard extends StatelessWidget {
  const _IncomingOfferCard({
    required this.offer,
    required this.isSubmitting,
    required this.onAccept,
    required this.onReject,
  });

  final CommunityOfferEntity offer;
  final bool isSubmitting;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [AppShadows.softCard],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.requestTitle ?? 'عرض على طلب #${offer.requestId}',
            style: AppStyles.hendi500Size20,
          ),
          SizedBox(height: 8.h),
          Text(
            '${offer.offererName} • ${offer.proposedPrice.toStringAsFixed(0)} ج.م',
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.smallSecondaryColor,
            ),
          ),
          if (offer.message.trim().isNotEmpty) ...[
            SizedBox(height: 8.h),
            Text(offer.message, style: AppStyles.bodySmall),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: isSubmitting ? null : onReject,
                  child: const Text('رفض'),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: isSubmitting ? null : onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('قبول'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyOfferCard extends StatelessWidget {
  const _MyOfferCard({required this.offer});

  final CommunityOfferEntity offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            offer.requestTitle ?? 'طلب #${offer.requestId}',
            style: AppStyles.hendi500Size20,
          ),
          SizedBox(height: 6.h),
          Text(
            '${offer.proposedPrice.toStringAsFixed(0)} ج.م • ${offer.status}',
            style: AppStyles.bodyMedium.copyWith(
              color: AppColors.smallSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoTag extends StatelessWidget {
  const _InfoTag({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffF0EEFF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppStyles.bodySmall.copyWith(
              color: AppColors.smallSecondaryColor,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
          SizedBox(width: 6.w),
          Icon(icon, size: 16.sp, color: AppColors.primaryColor),
        ],
      ),
    );
  }
}
