import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

abstract class NotificationRepository {
  Future<Either<Failure, Map<String, dynamic>>> getNotifications({
    required int page,
    required int pageSize,
  });
  Future<Either<Failure, void>> readNotification(int id);
  Future<Either<Failure, void>> readAllNotifications();
  Future<Either<Failure, int>> getUnreadCount();
}
