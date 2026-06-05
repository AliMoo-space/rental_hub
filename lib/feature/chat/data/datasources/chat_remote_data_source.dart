import 'package:rental_hub/core/databases/api/api_consumer.dart';
import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/chat/data/models/conversation_model.dart';
import 'package:rental_hub/feature/chat/data/models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations();
  Future<List<MessageModel>> getMessages({required int conversationId});
  Future<ConversationModel> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  });
  Future<void> reportMessage({required int messageId, String? reason});
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final ApiConsumer apiConsumer;

  ChatRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<List<ConversationModel>> getConversations() async {
    final response = await apiConsumer.get(EndPoints.chatConversationsEndpoint);
    return _parseConversationList(response.data);
  }

  @override
  Future<List<MessageModel>> getMessages({required int conversationId}) async {
    if (conversationId <= 0) {
      return const [];
    }

    final response = await apiConsumer.get(
      EndPoints.chatMessagesEndpoint(conversationId),
      queryParameters: const {'page': 1, 'pageSize': 100},
    );
    return _parseMessageList(response.data);
  }

  @override
  Future<ConversationModel> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  }) async {
    final conversations = await getConversations();
    for (final conversation in conversations) {
      if (conversation.sellerId == sellerId ||
          (productId != null && conversation.productId == productId)) {
        return conversation;
      }
    }

    return ConversationModel.draft(
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      productId: productId,
      productName: productName,
    );
  }

  @override
  Future<void> reportMessage({required int messageId, String? reason}) async {
    await apiConsumer.post(
      EndPoints.chatReportMessageEndpoint(messageId),
      data: reason == null || reason.trim().isEmpty
          ? const <String, dynamic>{}
          : {'reason': reason},
    );
  }

  List<ConversationModel> _parseConversationList(dynamic raw) {
    final collection = _extractCollection(raw);
    return collection
        .whereType<Map>()
        .map(
          (item) => ConversationModel.fromJson(
            Map<String, dynamic>.from(item),
          ),
        )
        .toList();
  }

  List<MessageModel> _parseMessageList(dynamic raw) {
    final collection = _extractCollection(raw);
    return collection
        .whereType<Map>()
        .map((item) => MessageModel.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  List<dynamic> _extractCollection(dynamic raw) {
    if (raw is List) {
      return raw;
    }

    if (raw is Map) {
      final map = Map<String, dynamic>.from(ResponseParser.extractDataPayload(raw));
      final directItems = map['items'];
      if (directItems is List) return directItems;

      final data = map['data'];
      if (data is List) return data;

      if (map['results'] is List) return map['results'] as List;

      if (map['messages'] is List) return map['messages'] as List;

      if (map['conversations'] is List) return map['conversations'] as List;

      return [map];
    }

    return const [];
  }
}
