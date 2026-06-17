import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/feature/subscription/data/datasource/subscription_remote_data_source.dart';

class _FakeApiConsumer implements ApiConsumer {
  _FakeApiConsumer({required this.outcomes});

  final List<Object> outcomes;
  int getCalls = 0;
  final List<String> requestedPaths = [];

  @override
  Future<Response<dynamic>> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) async {
    getCalls++;
    requestedPaths.add(path);

    if (getCalls <= outcomes.length) {
      final outcome = outcomes[getCalls - 1];
      if (outcome is Exception) {
        throw outcome;
      }

      return outcome as Response<dynamic>;
    }

    throw StateError('Unexpected extra get() call');
  }

  @override
  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool skipAuth = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    bool skipAuth = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    bool skipAuth = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    bool skipAuth = false,
  }) {
    throw UnimplementedError();
  }
}

Response<dynamic> _activeSubscriptionResponse(bool value) {
  return Response<dynamic>(
    data: {
      'data': {'hasActiveSubscription': value},
    },
    requestOptions: RequestOptions(path: '/api/UserDashboard/subscription'),
    statusCode: 200,
  );
}

Response<dynamic> _alternateActiveSubscriptionResponse() {
  return Response<dynamic>(
    data: {
      'data': {'isActive': 'true'},
    },
    requestOptions: RequestOptions(path: '/api/UserDashboard/subscription'),
    statusCode: 200,
  );
}

void main() {
  group('SubscriptionRemoteDataSourceImpl.getActiveSubscription', () {
    test('calls the user dashboard subscription endpoint', () async {
      final api = _FakeApiConsumer(
        outcomes: [_activeSubscriptionResponse(true)],
      );
      final dataSource = SubscriptionRemoteDataSourceImpl(api);

      final result = await dataSource.getActiveSubscription();

      expect(api.getCalls, 1);
      expect(api.requestedPaths, equals(['/api/UserDashboard/subscription']));
      expect(result.hasActiveSubscription, isTrue);
    });

    test('retries on timeout and succeeds on a later attempt', () async {
      final api = _FakeApiConsumer(
        outcomes: [
          ConnectionTimeoutException(
            ErrorModel(statusCode: 408, message: 'timeout 1', errors: {}),
          ),
          ConnectionTimeoutException(
            ErrorModel(statusCode: 408, message: 'timeout 2', errors: {}),
          ),
          _activeSubscriptionResponse(true),
        ],
      );
      final dataSource = SubscriptionRemoteDataSourceImpl(api);

      final result = await dataSource.getActiveSubscription();

      expect(api.getCalls, 3);
      expect(result.hasActiveSubscription, isTrue);
    });

    test('parses alternate response shapes safely', () async {
      final api = _FakeApiConsumer(
        outcomes: [_alternateActiveSubscriptionResponse()],
      );
      final dataSource = SubscriptionRemoteDataSourceImpl(api);

      final result = await dataSource.getActiveSubscription();

      expect(api.getCalls, 1);
      expect(result.hasActiveSubscription, isTrue);
    });

    test('returns a safe default on forbidden responses', () async {
      final api = _FakeApiConsumer(
        outcomes: [
          ForbiddenException(
            ErrorModel(statusCode: 403, message: 'forbidden', errors: {}),
          ),
        ],
      );
      final dataSource = SubscriptionRemoteDataSourceImpl(api);

      final result = await dataSource.getActiveSubscription();

      expect(api.getCalls, 1);
      expect(result.hasActiveSubscription, isFalse);
    });

    test('returns a safe default after repeated timeouts', () async {
      final api = _FakeApiConsumer(
        outcomes: [
          ConnectionTimeoutException(
            ErrorModel(statusCode: 408, message: 'timeout 1', errors: {}),
          ),
          ConnectionTimeoutException(
            ErrorModel(statusCode: 408, message: 'timeout 2', errors: {}),
          ),
          ConnectionTimeoutException(
            ErrorModel(statusCode: 408, message: 'timeout 3', errors: {}),
          ),
        ],
      );
      final dataSource = SubscriptionRemoteDataSourceImpl(api);

      final result = await dataSource.getActiveSubscription();

      expect(api.getCalls, 3);
      expect(result.hasActiveSubscription, isFalse);
    });
  });
}
