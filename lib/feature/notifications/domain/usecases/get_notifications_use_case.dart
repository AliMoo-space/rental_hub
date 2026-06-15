import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/notifications/domain/repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository repository;

  GetNotificationsUseCase({required this.repository});

  Future<Either<Failure, Map<String, dynamic>>> call({
    required int page,
    required int pageSize,
  }) {
    return repository.getNotifications(page: page, pageSize: pageSize);
  }
}
