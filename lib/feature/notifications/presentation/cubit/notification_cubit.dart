import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rental_hub/feature/notifications/domain/entities/notification_entity.dart';
import 'package:rental_hub/feature/notifications/domain/usecases/get_notifications_use_case.dart';
import 'package:rental_hub/feature/notifications/domain/usecases/get_unread_notifications_count_use_case.dart';
import 'package:rental_hub/feature/notifications/domain/usecases/read_all_notifications_use_case.dart';
import 'package:rental_hub/feature/notifications/domain/usecases/read_notification_use_case.dart';
import 'package:rental_hub/feature/notifications/presentation/cubit/notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final ReadNotificationUseCase readNotificationUseCase;
  final ReadAllNotificationsUseCase readAllNotificationsUseCase;
  final GetUnreadNotificationsCountUseCase getUnreadCountUseCase;

  int _currentPage = 1;
  static const int _pageSize = 20;

  NotificationCubit({
    required this.getNotificationsUseCase,
    required this.readNotificationUseCase,
    required this.readAllNotificationsUseCase,
    required this.getUnreadCountUseCase,
  }) : super(NotificationInitial());

  Future<void> fetchNotifications({bool isRefresh = false}) async {
    if (isRefresh) {
      _currentPage = 1;
    }

    if (state is NotificationLoaded && !isRefresh) {
      final currentState = state as NotificationLoaded;
      if (currentState.hasReachedMax) return;
    }

    if (isRefresh || state is! NotificationLoaded) {
      emit(NotificationLoading());
    }

    final result = await getNotificationsUseCase(page: _currentPage, pageSize: _pageSize);

    result.fold(
      (failure) {
        if (state is! NotificationLoaded) {
          emit(NotificationError(message: failure.errMessage));
        }
      },
      (data) {
        final List<NotificationEntity> newNotifications = data['notifications'] ?? [];
        final int unreadCount = data['unreadCount'] ?? 0;

        if (state is NotificationLoaded && !isRefresh) {
          final currentState = state as NotificationLoaded;
          emit(currentState.copyWith(
            notifications: List.of(currentState.notifications)..addAll(newNotifications),
            unreadCount: unreadCount,
            hasReachedMax: newNotifications.length < _pageSize,
          ));
        } else {
          emit(NotificationLoaded(
            notifications: newNotifications,
            unreadCount: unreadCount,
            hasReachedMax: newNotifications.length < _pageSize,
          ));
        }
        _currentPage++;
      },
    );
  }

  Future<void> readNotification(int id) async {
    final result = await readNotificationUseCase(id);

    result.fold(
      (failure) {}, // Handle error silently or show toast if needed
      (_) {
        if (state is NotificationLoaded) {
          final currentState = state as NotificationLoaded;
          final updatedNotifications = currentState.notifications.map((notification) {
            if (notification.id == id && !notification.isRead) {
              return NotificationEntity(
                id: notification.id,
                title: notification.title,
                body: notification.body,
                isRead: true,
                createdAt: notification.createdAt,
                readAt: DateTime.now(),
              );
            }
            return notification;
          }).toList();

          final int updatedUnreadCount = (currentState.unreadCount > 0)
              ? currentState.unreadCount - 1
              : 0;

          emit(currentState.copyWith(
            notifications: updatedNotifications,
            unreadCount: updatedUnreadCount,
          ));
        }
      },
    );
  }

  Future<void> readAllNotifications() async {
    final result = await readAllNotificationsUseCase();

    result.fold(
      (failure) {},
      (_) {
        if (state is NotificationLoaded) {
          final currentState = state as NotificationLoaded;
          final updatedNotifications = currentState.notifications.map((notification) {
            if (!notification.isRead) {
              return NotificationEntity(
                id: notification.id,
                title: notification.title,
                body: notification.body,
                isRead: true,
                createdAt: notification.createdAt,
                readAt: DateTime.now(),
              );
            }
            return notification;
          }).toList();

          emit(currentState.copyWith(
            notifications: updatedNotifications,
            unreadCount: 0,
          ));
        }
      },
    );
  }

  Future<void> fetchUnreadCount() async {
    final result = await getUnreadCountUseCase();

    result.fold(
      (failure) {},
      (count) {
        if (state is NotificationLoaded) {
          emit((state as NotificationLoaded).copyWith(unreadCount: count));
        } else if (state is NotificationInitial) {
          // Keep it initial but maybe we can't store count until loaded.
        }
      },
    );
  }
}
