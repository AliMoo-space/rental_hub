import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/notifications/domain/repositories/notification_repository.dart';

class ReadAllNotificationsUseCase {
  final NotificationRepository repository;

  ReadAllNotificationsUseCase({required this.repository});

  Future<Either<Failure, void>> call() {
    return repository.readAllNotifications();
  }
}
