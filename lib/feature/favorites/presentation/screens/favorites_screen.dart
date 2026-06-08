import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:rental_hub/core/extensions/localization_extension.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/filter_header_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';

import 'package:rental_hub/feature/favorites/data/model/favorites_item_model.dart';
import 'package:rental_hub/feature/favorites/presentation/cubit/favorite_cubit.dart';

import 'package:rental_hub/feature/home/presentation/widgets/home_recommended_item_card_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  void initState() {
    super.initState();

    context.read<FavoriteCubit>().pagingController.refresh();
    context.read<FavoriteCubit>().pagingController.fetchNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<FavoriteCubit>();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.l10n.favorites, style: AppStyles.hendi500Size20),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
              child: FilterHeaderWidget(
                title: context.l10n.favorites,
                onFilterTap: () {},
                onSearchTap: () {},
                selectedFilter: 'All',
              ),
            ),

            HeightSpace(14),

            Expanded(
              child: PagedListView<int, FavoriteItemModel>(
                state: cubit.pagingController.value,

                fetchNextPage: cubit.pagingController.fetchNextPage,

                builderDelegate: PagedChildBuilderDelegate<FavoriteItemModel>(
                  itemBuilder: (context, item, index) {
                    return HomeRecommendedItemCardWidget(
                      product: item.toProductEntity(),
                      rating: item.averageRating,
                      onRatingChanged: (_) {},
                    );
                  },

                  firstPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),

                  newPageProgressIndicatorBuilder: (_) =>
                      const Center(child: CircularProgressIndicator()),

                  noItemsFoundIndicatorBuilder: (_) =>
                      const Center(child: Text('No favorites yet')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
