import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/incoming_offer_card.dart';

class IncomingOffersTab extends StatelessWidget {
  const IncomingOffersTab({super.key});

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
              return IncomingOfferCard(
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
