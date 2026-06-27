import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/domain/entities/community_request_entity.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_request_card.dart';
import 'package:rental_hub/feature/community/presentation/widgets/incoming_offer_card.dart';
import 'package:rental_hub/feature/community/presentation/widgets/submit_community_offer_sheet.dart';

class CommunityRequestDetailsScreen extends StatefulWidget {
  final int requestId;

  const CommunityRequestDetailsScreen({super.key, required this.requestId});

  @override
  State<CommunityRequestDetailsScreen> createState() =>
      _CommunityRequestDetailsScreenState();
}

class _CommunityRequestDetailsScreenState
    extends State<CommunityRequestDetailsScreen> {
  CommunityRequestEntity? _request;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final request = await context
        .read<CommunityRequestsCubit>()
        .loadRequestDetails(widget.requestId);

    if (!mounted) return;

    if (request != null) {
      setState(() {
        _request = request;
        _isLoading = false;
      });
      context.read<CommunityOffersCubit>().loadRequestOffers(widget.requestId);
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'فشل تحميل تفاصيل الطلب';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _request?.title ?? 'تفاصيل الطلب',
          style: AppStyles.hendi500Size20,
        ),
      ),
      body: _buildBody(),
      floatingActionButton: _request != null
          ? FloatingActionButton.extended(
              onPressed: () =>
                  showSubmitCommunityOfferSheet(context, _request!),
              backgroundColor: AppColors.primaryColor,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('تقديم عرض'),
            )
          : null,
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: EdgeInsetsDirectional.all(18.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                size: 48.sp,
                color: AppColors.smallSecondaryColor,
              ),
              SizedBox(height: 12.h),
              Text(
                _errorMessage!,
                style: AppStyles.bodyMedium.copyWith(
                  color: AppColors.smallSecondaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              TextButton.icon(
                onPressed: _loadData,
                icon: const Icon(Icons.refresh),
                label: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: CustomScrollView(
        slivers: [
          if (_request != null)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(18.w, 12.h, 18.w, 0),
                child: CommunityRequestCard(
                  request: _request!,
                  showSubmitButton: false,
                  isCompact: true,
                ),
              ),
            ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(18.w, 20.h, 18.w, 10.h),
              child: Text('العروض المقدمة', style: AppStyles.hendi500Size20),
            ),
          ),
          BlocBuilder<CommunityOffersCubit, CommunityOffersState>(
            builder: (context, state) {
              final offers = state.requestOffers;

              if (state.isLoadingRequestOffers && offers.isEmpty) {
                return const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              if (offers.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 48.sp,
                          color: AppColors.smallSecondaryColor,
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          'لا توجد عروض بعد',
                          style: AppStyles.bodyMedium.copyWith(
                            color: AppColors.smallSecondaryColor,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'كن أول من يقدم عرضاً لهذا الطلب',
                          style: AppStyles.bodySmall.copyWith(
                            color: AppColors.smallSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final offer = offers[index];
                  final isOwner = _request?.userId == offer.offererId;
                  return Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(
                      18.w,
                      0,
                      18.w,
                      12.h,
                    ),
                    child: IncomingOfferCard(
                      offer: offer,
                      isSubmitting: state.isSubmitting,
                      onAccept: isOwner
                          ? () => context
                                .read<CommunityOffersCubit>()
                                .acceptOffer(offer.id)
                          : () {},
                      onReject: isOwner
                          ? () => context
                                .read<CommunityOffersCubit>()
                                .rejectOffer(offer.id)
                          : () {},
                    ),
                  );
                }, childCount: offers.length),
              );
            },
          ),
        ],
      ),
    );
  }
}
