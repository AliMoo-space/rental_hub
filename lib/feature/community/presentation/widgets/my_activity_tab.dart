import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_request_card.dart';
import 'package:rental_hub/feature/community/presentation/widgets/my_offer_card.dart';

class MyActivityTab extends StatelessWidget {
  const MyActivityTab({super.key});

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
                        child: CommunityRequestCard(
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
                        child: MyOfferCard(offer: offer),
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
