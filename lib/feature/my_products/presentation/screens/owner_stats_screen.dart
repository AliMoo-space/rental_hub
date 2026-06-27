import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rental_hub/core/routing/app_routes.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/core/widgets/primary_button_widget.dart';
import 'package:rental_hub/core/widgets/spacing_widgets.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_cubit.dart';
import 'package:rental_hub/feature/my_products/presentation/cubit/owner_stats_state.dart';

class OwnerStatsScreen extends StatefulWidget {
  const OwnerStatsScreen({super.key});

  @override
  State<OwnerStatsScreen> createState() => _OwnerStatsScreenState();
}

class _OwnerStatsScreenState extends State<OwnerStatsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<OwnerStatsCubit>().loadOwnerStats();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OwnerStatsCubit, OwnerStatsState>(
      builder: (context, state) {
        if (state.isOwnerStatsLoading && state.ownerStats == null) {
          return const Scaffold(body: LoadingWidget());
        }

        return Scaffold(
          backgroundColor: const Color(0xffF7F8FC),
          appBar: AppBar(title: const Text('لوحة المالك')),
          body: RefreshIndicator(
            onRefresh: context.read<OwnerStatsCubit>().loadOwnerStats,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(16.w),
              children: [
                if (state.errorMessage.isNotEmpty) ...[
                  _ErrorBanner(message: state.errorMessage),
                  verticalSpacing(16),
                ],
                if (state.ownerStats != null)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final crossAxisCount = constraints.maxWidth < 380 ? 1 : 2;

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          _StatCard(
                            label: 'إجمالي المنتجات',
                            value: state.ownerStats!.totalProducts.toString(),
                            icon: Icons.inventory_2_outlined,
                          ),
                          _StatCard(
                            label: 'المنتجات النشطة',
                            value: state.ownerStats!.activeProducts.toString(),
                            icon: Icons.check_circle_outline,
                          ),
                          _StatCard(
                            label: 'المنتجات الموقوفة',
                            value: state.ownerStats!.suspendedProducts
                                .toString(),
                            icon: Icons.pause_circle_outline,
                          ),
                          _StatCard(
                            label: 'إجمالي الإيجارات',
                            value: state.ownerStats!.totalRentals.toString(),
                            icon: Icons.receipt_long_outlined,
                          ),
                          _StatCard(
                            label: 'إجمالي الأرباح',
                            value:
                                'ج.م ${state.ownerStats!.totalEarnings.toStringAsFixed(0)}',
                            icon: Icons.payments_outlined,
                          ),
                        ],
                      );
                    },
                  ),
                verticalSpacing(20),
                PrimaryButtonWidget(
                  buttonText: 'عرض منتجاتي',
                  onPress: () => context.pushNamed(AppRoutes.myProductsScreen),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: AppColors.primaryColor, size: 28.sp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
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
        ],
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  final String message;

  const _ErrorBanner({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Text(message, style: AppStyles.bodyMedium),
    );
  }
}
