import 'dart:developer' as developer;

import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/subscription/data/models/subscription_model.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionResponseModel> getSubscriptions();
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
}
