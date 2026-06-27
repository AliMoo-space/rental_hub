import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_cubit.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_state.dart';

class ProductStatsScreen extends StatefulWidget {
  final int productId;

  const ProductStatsScreen({super.key, required this.productId});

  @override
  State<ProductStatsScreen> createState() => _ProductStatsScreenState();
}

class _ProductStatsScreenState extends State<ProductStatsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<OwnerStatsCubit>().loadProductStats(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerStatsCubit, OwnerStatsState>(
      builder: (context, state) {
        if (state.isProductStatsLoading && state.productStats == null) {
          return const Scaffold(body: LoadingWidget());
        }

        final stats = state.productStats;
        return Scaffold(
          backgroundColor: const Color(0xffF7F8FC),
          appBar: AppBar(title: const Text('إحصائيات المنتج')),
          body: RefreshIndicator(
            onRefresh: () => context.read<OwnerStatsCubit>().loadProductStats(
              widget.productId,
            ),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              children: [
                if (state.errorMessage.isNotEmpty) ...[
                  Text(
                    state.errorMessage,
                    style: AppStyles.bodyMedium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  verticalSpacing(12),
                ],
                if (stats != null) ...[
                  _MetricCard(
                    label: 'عدد الإيجارات',
                    value: stats.rentalsCount.toString(),
                    icon: Icons.event_available_outlined,
                  ),
                  verticalSpacing(12),
                  _MetricCard(
                    label: 'الأرباح',
                    value: 'ج.م ${stats.earnings.toStringAsFixed(0)}',
                    icon: Icons.payments_outlined,
                  ),
                  verticalSpacing(12),
                  _MetricCard(
                    label: 'متوسط التقييم',
                    value: stats.averageRating.toStringAsFixed(1),
                    icon: Icons.star_outline,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _MetricCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColors.primaryColor),
          ),
          horizontalSpacing(14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.titleMedium.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                verticalSpacing(4),
                Text(
                  label,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
