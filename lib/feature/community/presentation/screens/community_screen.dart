import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/utils/snack_bar_widget.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_offers_cubit.dart';
import 'package:rental_hub/feature/community/presentation/cubit/community_requests_cubit.dart';
import 'package:rental_hub/feature/community/presentation/widgets/community_feed_tab.dart';
import 'package:rental_hub/feature/community/presentation/widgets/incoming_offers_tab.dart';
import 'package:rental_hub/feature/community/presentation/widgets/my_activity_tab.dart';
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
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final currentIndex = _tabController.index;
    if (currentIndex == _previousIndex) return;
    _previousIndex = currentIndex;

    if (currentIndex == 1) {
      context.read<CommunityOffersCubit>().loadIncomingOffers();
    } else if (currentIndex == 2) {
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
    showMsg(message, context);
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
                      CommunityFeedTab(searchController: _searchController),
                      const IncomingOffersTab(),
                      const MyActivityTab(),
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
