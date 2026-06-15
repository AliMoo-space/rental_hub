import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/notifications/data/datasources/notification_remote_data_source.dart';
import 'package:rental_hub/feature/notifications/data/models/notification_model.dart';
import 'package:rental_hub/feature/notifications/domain/entities/notification_entity.dart';
import 'package:rental_hub/feature/notifications/domain/repositories/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Map<String, dynamic>>> getNotifications({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await remoteDataSource.getNotifications(
        page: page,
        pageSize: pageSize,
      );

      final payload = ResponseParser.extractDataPayload(response);

      List<NotificationEntity> notifications = [];
      int unreadCount = 0;

      if (payload.containsKey('notifications') && payload['notifications'] is List) {
        notifications = (payload['notifications'] as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      if (payload.containsKey('unreadCount') && payload['unreadCount'] is int) {
        unreadCount = payload['unreadCount'] as int;
      }

      return Right({
        'notifications': notifications,
        'unreadCount': unreadCount,
      });
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.message));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> readNotification(int id) async {
    try {
      await remoteDataSource.readNotification(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.message));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> readAllNotifications() async {
    try {
      await remoteDataSource.readAllNotifications();
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.message));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final count = await remoteDataSource.getUnreadCount();
      return Right(count);
    } on ServerException catch (e) {
      return Left(Failure(errMessage: e.errorModel.message));
    } catch (e) {
      return Left(Failure(errMessage: e.toString()));
    }
  }
}
