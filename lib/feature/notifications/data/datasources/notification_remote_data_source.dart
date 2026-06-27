import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';

abstract class NotificationRemoteDataSource {
  Future<Map<String, dynamic>> getNotifications({
    required int page,
    required int pageSize,
  });
  Future<void> readNotification(int id);
  Future<void> readAllNotifications();
  Future<int> getUnreadCount();
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final ApiConsumer apiConsumer;

  NotificationRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<Map<String, dynamic>> getNotifications({
    required int page,
    required int pageSize,
  }) async {
    final response = await apiConsumer.get(
      EndPoints.notificationsEndpoint,
      queryParameters: {'page': page, 'pageSize': pageSize},
    );

    return response.data;
  }

  @override
  Future<void> readNotification(int id) async {
    await apiConsumer.put(EndPoints.readNotificationEndpoint(id));
  }

  @override
  Future<void> readAllNotifications() async {
    await apiConsumer.put(EndPoints.readAllNotificationsEndpoint);
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await apiConsumer.get(
      EndPoints.unreadNotificationsCountEndpoint,
    );
    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('unreadCount')) {
      return data['unreadCount'] as int;
    } else if (data is int) {
      return data;
    }
    return 0; // Fallback
  }
}
