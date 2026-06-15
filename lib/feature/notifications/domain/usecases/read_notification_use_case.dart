import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/notifications/domain/repositories/notification_repository.dart';

class ReadNotificationUseCase {
  final NotificationRepository repository;

  ReadNotificationUseCase({required this.repository});

  Future<Either<Failure, void>> call(int id) {
    return repository.readNotification(id);
  }
}
