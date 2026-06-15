import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/notifications/domain/repositories/notification_repository.dart';

class GetUnreadNotificationsCountUseCase {
  final NotificationRepository repository;

  GetUnreadNotificationsCountUseCase({required this.repository});

  Future<Either<Failure, int>> call() {
    return repository.getUnreadCount();
  }
}
