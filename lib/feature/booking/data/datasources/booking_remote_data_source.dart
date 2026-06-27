import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/booking/data/models/create_rental_order_dto.dart';
import 'package:rental_hub/feature/booking/data/models/rental_order_model.dart';
import 'package:rental_hub/feature/booking/data/models/rental_order_stats_model.dart';

abstract class BookingRemoteDataSource {
  Future<RentalOrderModel> createRentalOrder(CreateRentalOrderDto dto);
  Future<RentalOrderStatsModel> getRenterOrderStats();
  Future<List<RentalOrderModel>> getMyOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<List<RentalOrderModel>> getMyListingsOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  });
  Future<RentalOrderModel> getRentalOrderById(int id);
  Future<void> approveRentalOrder(int id);
  Future<void> rejectRentalOrder(int id, {String? reason});
  Future<void> cancelRentalOrder(int id);
  Future<void> shipRentalOrder(int id);
  Future<void> confirmReceiptRentalOrder(int id);
  Future<void> returnRentalOrder(int id, {String? reason});
}

class BookingRemoteDataSourceImpl implements BookingRemoteDataSource {
  final ApiConsumer api;

  BookingRemoteDataSourceImpl({required this.api});

  @override
  Future<RentalOrderModel> createRentalOrder(CreateRentalOrderDto dto) async {
    final response = await api.post(EndPoints.rentalOrder, data: dto.toJson());
    final payload = ResponseParser.extractDataPayload(response.data);
    return RentalOrderModel.fromJson(payload);
  }

  @override
  Future<RentalOrderStatsModel> getRenterOrderStats() async {
    final response = await api.get(EndPoints.renterOrderStats);
    final payload = ResponseParser.extractDataPayload(response.data);
    return RentalOrderStatsModel.fromJson(payload);
  }

  @override
  Future<List<RentalOrderModel>> getMyOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final Map<String, dynamic> queryParams = {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }
    if (searchTerm != null && searchTerm.isNotEmpty) {
      queryParams['searchTerm'] = searchTerm;
    }
    final response = await api.get(
      EndPoints.rentalMyOrders,
      queryParameters: queryParams,
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    final items =
        payload['items'] as List? ?? response.data['data'] as List? ?? [];
    return items.map((e) => RentalOrderModel.fromJson(e)).toList();
  }

  @override
  Future<List<RentalOrderModel>> getMyListingsOrders({
    String? status,
    String? searchTerm,
    int pageNumber = 1,
    int pageSize = 10,
  }) async {
    final Map<String, dynamic> queryParams = {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };
    if (status != null && status.isNotEmpty) {
      queryParams['status'] = status;
    }
    if (searchTerm != null && searchTerm.isNotEmpty) {
      queryParams['searchTerm'] = searchTerm;
    }
    final response = await api.get(
      EndPoints.rentalMyListings,
      queryParameters: queryParams,
    );
    final payload = ResponseParser.extractDataPayload(response.data);
    final items =
        payload['items'] as List? ?? response.data['data'] as List? ?? [];
    return items.map((e) => RentalOrderModel.fromJson(e)).toList();
  }

  @override
  Future<RentalOrderModel> getRentalOrderById(int id) async {
    final response = await api.get(EndPoints.rentalOrderById(id));
    final payload = ResponseParser.extractDataPayload(response.data);
    return RentalOrderModel.fromJson(payload);
  }

  @override
  Future<void> approveRentalOrder(int id) async {
    await api.put(EndPoints.approveRentalOrder(id));
  }

  @override
  Future<void> rejectRentalOrder(int id, {String? reason}) async {
    await api.put(EndPoints.rejectRentalOrder(id), data: reason);
  }

  @override
  Future<void> cancelRentalOrder(int id) async {
    await api.put(EndPoints.cancelRentalOrder(id));
  }

  @override
  Future<void> shipRentalOrder(int id) async {
    await api.put(EndPoints.shipRentalOrder(id));
  }

  @override
  Future<void> confirmReceiptRentalOrder(int id) async {
    await api.put(EndPoints.confirmReceiptRentalOrder(id));
  }

  @override
  Future<void> returnRentalOrder(int id, {String? reason}) async {
    await api.put(EndPoints.returnRentalOrder(id), data: reason);
  }
}
