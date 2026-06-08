import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/error_model.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/community/data/models/community_offer_model.dart';
import 'package:rental_hub/feature/community/data/models/community_request_model.dart';
import 'package:rental_hub/feature/community/data/models/create_community_request_body.dart';
import 'package:rental_hub/feature/community/domain/entities/community_requests_query.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_offer_params.dart';
import 'package:rental_hub/feature/community/domain/entities/create_community_request_params.dart';

abstract class CommunityRemoteDataSource {
  Future<CommunityRequestsPageModel> getRequests(CommunityRequestsQuery query);

  Future<CommunityRequestModel> getRequestById(int id);

  Future<String> createRequest(CreateCommunityRequestParams params);

  Future<String> createOffer(CreateCommunityOfferParams params);

  Future<List<CommunityOfferModel>> getMyRequestsOffers();

  Future<List<CommunityOfferModel>> getMyOffers();

  Future<CommunityRequestsPageModel> getMyRequests(
    MyCommunityRequestsQuery query,
  );

  Future<String> acceptOffer(int offerId);

  Future<String> rejectOffer(int offerId);
}

class CommunityRemoteDataSourceImpl implements CommunityRemoteDataSource {
  final ApiConsumer apiConsumer;

  CommunityRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<CommunityRequestsPageModel> getRequests(
    CommunityRequestsQuery query,
  ) async {
    final response = await apiConsumer.get(
      EndPoints.communityRequests,
      queryParameters: _requestsQueryMap(query),
    );
    return _parseRequestsPage(response.data);
  }

  @override
  Future<CommunityRequestModel> getRequestById(int id) async {
    final response = await apiConsumer.get(EndPoints.communityRequestById(id));
    final payload = ResponseParser.extractDataPayload(response.data);
    return CommunityRequestModel.fromJson(payload);
  }

  @override
  Future<String> createRequest(CreateCommunityRequestParams params) async {
    final response = await apiConsumer.post(
      EndPoints.communityRequests,
      data: await CreateCommunityRequestBody(params).toFormData(),
      isFormData: true,
    );
    return _extractActionMessage(response.data, 'Request created successfully');
  }

  @override
  Future<String> createOffer(CreateCommunityOfferParams params) async {
    final response = await apiConsumer.post(
      EndPoints.communityOffers,
      data: {
        'requestId': params.requestId,
        'proposedPrice': params.proposedPrice,
        'message': params.message,
        'governorate': params.governorate,
        'city': params.city,
        'address': params.address,
      },
    );
    return _extractActionMessage(response.data, 'Offer submitted successfully');
  }

  @override
  Future<List<CommunityOfferModel>> getMyRequestsOffers() async {
    final response = await apiConsumer.get(EndPoints.communityMyRequestsOffers);
    return _parseOffersList(response.data);
  }

  @override
  Future<List<CommunityOfferModel>> getMyOffers() async {
    final response = await apiConsumer.get(EndPoints.communityMyOffers);
    return _parseOffersList(response.data);
  }

  @override
  Future<CommunityRequestsPageModel> getMyRequests(
    MyCommunityRequestsQuery query,
  ) async {
    final response = await apiConsumer.get(
      EndPoints.communityMyRequests,
      queryParameters: {
        if (query.status != null && query.status!.trim().isNotEmpty)
          'status': query.status,
        'pageNumber': query.pageNumber,
        'pageSize': query.pageSize,
      },
    );
    return _parseRequestsPage(response.data);
  }

  @override
  Future<String> acceptOffer(int offerId) async {
    final response = await apiConsumer.put(
      EndPoints.communityOfferAction(offerId, 'accept'),
    );
    return _extractActionMessage(response.data, 'Offer accepted');
  }

  @override
  Future<String> rejectOffer(int offerId) async {
    final response = await apiConsumer.put(
      EndPoints.communityOfferAction(offerId, 'reject'),
    );
    return _extractActionMessage(response.data, 'Offer rejected');
  }

  Map<String, dynamic> _requestsQueryMap(CommunityRequestsQuery query) {
    return {
      if (query.categoryId != null) 'categoryId': query.categoryId,
      if (query.subcategoryId != null) 'subcategoryId': query.subcategoryId,
      if (query.governorate != null && query.governorate!.trim().isNotEmpty)
        'governorate': query.governorate,
      if (query.city != null && query.city!.trim().isNotEmpty)
        'city': query.city,
      if (query.search != null && query.search!.trim().isNotEmpty)
        'search': query.search,
      'pageNumber': query.pageNumber,
      'pageSize': query.pageSize,
    };
  }

  CommunityRequestsPageModel _parseRequestsPage(dynamic raw) {
    final payload = ResponseParser.extractDataPayload(raw);

    if (payload.containsKey('items')) {
      return CommunityRequestsPageModel.fromJson(payload);
    }

    if (payload['requests'] is List) {
      return CommunityRequestsPageModel.fromJson(
        Map<String, dynamic>.from(payload),
      );
    }

    if (raw is List) {
      return CommunityRequestsPageModel.fromList(raw);
    }

    if (payload.isNotEmpty) {
      return CommunityRequestsPageModel(
        items: [CommunityRequestModel.fromJson(payload)],
        totalCount: 1,
        pageNumber: 1,
        pageSize: 1,
        totalPages: 1,
        hasPrevious: false,
        hasNext: false,
      );
    }

    return const CommunityRequestsPageModel(
      items: [],
      totalCount: 0,
      pageNumber: 1,
      pageSize: 10,
      totalPages: 0,
      hasPrevious: false,
      hasNext: false,
    );
  }

  List<CommunityOfferModel> _parseOffersList(dynamic raw) {
    final payload = ResponseParser.extractDataPayload(raw);

    if (payload.containsKey('items')) {
      return CommunityOffersPageModel.fromJson(
        payload,
      ).items.whereType<CommunityOfferModel>().toList();
    }

    if (raw is List) {
      return CommunityOffersPageModel.fromJson(
        raw,
      ).items.whereType<CommunityOfferModel>().toList();
    }

    if (payload.isNotEmpty && payload['id'] != null) {
      return [CommunityOfferModel.fromJson(payload)];
    }

    return const [];
  }

  String _extractActionMessage(dynamic raw, String defaultMessage) {
    final payload = ResponseParser.extractMessagePayload(
      raw,
      defaultMessage: defaultMessage,
    );
    final message = payload['message']?.toString().trim() ?? '';
    if (message.isEmpty) {
      throw ServerException(
        ErrorModel(
          statusCode: 500,
          message: 'Invalid community response format',
          errors: {},
        ),
      );
    }
    return message;
  }
}
