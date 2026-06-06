import 'dart:async';
import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/subscription/data/models/subscription_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionResponseModel> getSubscriptions();

  Future<SubscriptionActionResultModel> subscribe({
    required int subscriptionId,
  });
  Future<SubscriptionActiveModel> getActiveSubscription();
}

class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final ApiConsumer _api;

  static const int _maxAttempts = 3;
  static const Duration _initialBackoff = Duration(milliseconds: 300);

  SubscriptionRemoteDataSourceImpl(this._api);

  @override
  Future<SubscriptionResponseModel> getSubscriptions() async {
    final path = EndPoints.subscriptionEndpoint;
    developer.log(
      'SubscriptionRemoteDataSourceImpl.getSubscriptions: GET $path',
      name: 'Subscription',
    );

    try {
      final response = await _api.get(path);
      developer.log(
        'SubscriptionRemoteDataSourceImpl.getSubscriptions: response status=${response.statusCode}\n'
        'response body=${response.data}',
        name: 'Subscription',
      );

      final payload = ResponseParser.extractDataPayload(response.data);
      developer.log(
        'SubscriptionRemoteDataSourceImpl.getSubscriptions: payload=$payload',
        name: 'Subscription',
      );

      return SubscriptionResponseModel.fromJson(payload);
    } on ServerException catch (error) {
      developer.log(
        'SubscriptionRemoteDataSourceImpl.getSubscriptions: server error\n'
        'status=${error.errorModel.statusCode}\n'
        'message=${error.errorModel.message}',
        name: 'Subscription',
      );
      rethrow;
    } catch (error) {
      developer.log(
        'SubscriptionRemoteDataSourceImpl.getSubscriptions: unexpected error\n'
        'error=$error',
        name: 'Subscription',
      );
      rethrow;
    }
  }

  @override
  Future<SubscriptionActionResultModel> subscribe({
    required int subscriptionId,
  }) async {
    final path = EndPoints.subscriptionSubscribeEndpoint;
    developer.log(
      'SubscriptionRemoteDataSourceImpl.subscribe: POST $path\n'
      'subscriptionId=$subscriptionId',
      name: 'Subscription',
    );

    try {
      final response = await _api.post(
        path,
        data: {'subscriptionId': subscriptionId},
      );
      developer.log(
        'SubscriptionRemoteDataSourceImpl.subscribe: response status=${response.statusCode}\n'
        'response body=${response.data}',
        name: 'Subscription',
      );

      final payload = ResponseParser.extractMessagePayload(
        response.data,
        defaultMessage: 'Success',
      );

      developer.log(
        'SubscriptionRemoteDataSourceImpl.subscribe: payload=$payload',
        name: 'Subscription',
      );

      return SubscriptionActionResultModel.fromJson(payload);
    } on ServerException catch (error) {
      developer.log(
        'SubscriptionRemoteDataSourceImpl.subscribe: server error\n'
        'status=${error.errorModel.statusCode}\n'
        'message=${error.errorModel.message}',
        name: 'Subscription',
      );
      rethrow;
    } catch (error) {
      developer.log(
        'SubscriptionRemoteDataSourceImpl.subscribe: unexpected error\n'
        'error=$error',
        name: 'Subscription',
      );
      rethrow;
    }
  }

  @override
  Future<SubscriptionActiveModel> getActiveSubscription() async {
    for (var attempt = 1; attempt <= _maxAttempts; attempt++) {
      try {
        final path = EndPoints.userDashboardSubscriptionEndpoint;
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: attempt $attempt/$_maxAttempts\n'
          'GET $path',
          name: 'Subscription',
        );

        final response = await _api.get(path);
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: response status=${response.statusCode}\n'
          'response body=${response.data}',
          name: 'Subscription',
        );
        final payload = ResponseParser.extractDataPayload(response.data);

        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: success on attempt $attempt\n'
          'payload=$payload',
          name: 'Subscription',
        );

        return SubscriptionActiveModel.fromJson(payload);
      } on ForbiddenException catch (error) {
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: forbidden on attempt $attempt/$_maxAttempts\n'
          'status=${error.errorModel.statusCode}\n'
          'message=${error.errorModel.message}\n'
          'Returning inactive subscription so Home can continue rendering.',
          name: 'Subscription',
        );
        return const SubscriptionActiveModel(hasActiveSubscription: false);
      } on UnauthorizedException catch (error) {
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: unauthorized on attempt $attempt/$_maxAttempts\n'
          'status=${error.errorModel.statusCode}\n'
          'message=${error.errorModel.message}\n'
          'Returning inactive subscription so Home can continue rendering.',
          name: 'Subscription',
        );
        return const SubscriptionActiveModel(hasActiveSubscription: false);
      } on NotFoundException catch (error) {
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: endpoint not found on attempt $attempt/$_maxAttempts\n'
          'status=${error.errorModel.statusCode}\n'
          'message=${error.errorModel.message}\n'
          'Returning inactive subscription so Home can continue rendering.',
          name: 'Subscription',
        );
        return const SubscriptionActiveModel(hasActiveSubscription: false);
      } on ConnectionTimeoutException catch (error) {
        final isLastAttempt = attempt == _maxAttempts;
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: connection timeout on attempt $attempt/$_maxAttempts'
          '${isLastAttempt ? ' - returning safe default' : ' - retrying'}\n'
          'Error: ${error.errorModel.message}',
          name: 'Subscription',
        );

        if (isLastAttempt) {
          return const SubscriptionActiveModel(hasActiveSubscription: false);
        }

        await Future<void>.delayed(_backoffForAttempt(attempt));
      } on ReceiveTimeoutException catch (error) {
        final isLastAttempt = attempt == _maxAttempts;
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: receive timeout on attempt $attempt/$_maxAttempts'
          '${isLastAttempt ? ' - returning safe default' : ' - retrying'}\n'
          'Error: ${error.errorModel.message}',
          name: 'Subscription',
        );

        if (isLastAttempt) {
          return const SubscriptionActiveModel(hasActiveSubscription: false);
        }

        await Future<void>.delayed(_backoffForAttempt(attempt));
      } on ServerException catch (error) {
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: server error on attempt $attempt/$_maxAttempts\n'
          'status=${error.errorModel.statusCode}\n'
          'message=${error.errorModel.message}\n'
          'Returning inactive subscription so Home can continue rendering.',
          name: 'Subscription',
        );
        return const SubscriptionActiveModel(hasActiveSubscription: false);
      } catch (error) {
        developer.log(
          'SubscriptionRemoteDataSourceImpl.getActiveSubscription: unexpected error on attempt $attempt/$_maxAttempts\n'
          'error=$error\n'
          'Returning inactive subscription so Home can continue rendering.',
          name: 'Subscription',
        );
        return const SubscriptionActiveModel(hasActiveSubscription: false);
      }
    }

    return const SubscriptionActiveModel(hasActiveSubscription: false);
  }

  Duration _backoffForAttempt(int attempt) {
    final multiplier = 1 << (attempt - 1);
    return Duration(milliseconds: _initialBackoff.inMilliseconds * multiplier);
  }
}
