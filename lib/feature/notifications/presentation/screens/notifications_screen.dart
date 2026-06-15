import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rental_hub/core/styling/app_colors.dart';
import 'package:rental_hub/core/styling/app_styles.dart';
import 'package:rental_hub/core/widgets/loading_widget.dart';
import 'package:rental_hub/feature/notifications/presentation/cubit/notification_cubit.dart';
import 'package:rental_hub/feature/notifications/presentation/cubit/notification_state.dart';
import 'package:rental_hub/feature/notifications/presentation/widgets/notification_item_widget.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<NotificationCubit>().fetchNotifications();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationCubit>().fetchNotifications();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Notifications", // Consider moving to context.l10n later if needed
          style: AppStyles.titleMedium.copyWith(color: AppColors.textPrimaryColor),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              context.read<NotificationCubit>().readAllNotifications();
            },
            child: Text(
              "Mark all as read", // Consider moving to context.l10n
              style: AppStyles.bodySmall.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationLoading && state is! NotificationLoaded) {
            return const Center(child: LoadingWidget());
          } else if (state is NotificationError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: AppStyles.bodyMedium),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context.read<NotificationCubit>().fetchNotifications(isRefresh: true),
                    child: Text("Retry"),
                  ),
                ],
              ),
            );
          } else if (state is NotificationLoaded) {
            if (state.notifications.isEmpty) {
              return Center(
                child: Text(
                  "No notifications yet.", // Consider moving to context.l10n later
                  style: AppStyles.bodyMedium.copyWith(color: AppColors.textSecondaryColor),
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () => context.read<NotificationCubit>().fetchNotifications(isRefresh: true),
              color: AppColors.primaryColor,
              child: ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.notifications.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= state.notifications.length) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: const Center(child: LoadingWidget()),
                    );
                  }

                  final notification = state.notifications[index];
                  return NotificationItemWidget(
                    notification: notification,
                    onTap: () {
                      if (!notification.isRead) {
                        context.read<NotificationCubit>().readNotification(notification.id);
                      }
                    },
                  );
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
