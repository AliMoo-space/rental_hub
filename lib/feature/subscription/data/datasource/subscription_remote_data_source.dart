import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
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

  SubscriptionRemoteDataSourceImpl(this._api);

  @override
  Future<SubscriptionResponseModel> getSubscriptions() async {
    developer.log(
      'SubscriptionRemoteDataSourceImpl.getSubscriptions',
      name: 'Subscription',
    );

    final response = await _api.get(EndPoints.subscriptionEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);

    developer.log(
      'SubscriptionRemoteDataSourceImpl.getSubscriptions: Success\nPayload: $payload',
      name: 'Subscription',
    );

    return SubscriptionResponseModel.fromJson(payload);
  }

  @override
  Future<SubscriptionActionResultModel> subscribe({
    required int subscriptionId,
  }) async {
    developer.log(
      'SubscriptionRemoteDataSourceImpl.subscribe: subscriptionId=$subscriptionId',
      name: 'Subscription',
    );

    final response = await _api.post(
      EndPoints.subscriptionSubscribeEndpoint,
      data: {'subscriptionId': subscriptionId},
    );
    final payload = ResponseParser.extractMessagePayload(
      response.data,
      defaultMessage: 'Success',
    );

    developer.log(
      'SubscriptionRemoteDataSourceImpl.subscribe: Success\nPayload: $payload',
      name: 'Subscription',
    );

    return SubscriptionActionResultModel.fromJson(payload);
  }

  @override
  Future<SubscriptionActiveModel> getActiveSubscription() async {
    developer.log(
      'SubscriptionRemoteDataSourceImpl.getActiveSubscription',
      name: 'Subscription',
    );

    final response = await _api.get(EndPoints.subscriptionActiveEndpoint);
    final payload = ResponseParser.extractDataPayload(response.data);

    developer.log(
      'SubscriptionRemoteDataSourceImpl.getActiveSubscription: Success\nPayload: $payload',
      name: 'Subscription',
    );

    return SubscriptionActiveModel.fromJson(payload);
  }
}
