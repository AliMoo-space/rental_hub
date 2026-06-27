import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  const ConversationModel({
    required super.id,
    required super.sellerId,
    required super.sellerName,
    required super.sellerAvatar,
    required super.buyerId,
    required super.buyerName,
    required super.productId,
    required super.productName,
    required super.lastMessage,
    required super.lastMessageAt,
    required super.unreadCount,
    required super.isDraft,
  });

  factory ConversationModel.draft({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
    String? buyerId,
    String? buyerName,
  }) {
    return ConversationModel(
      id: 0,
      sellerId: sellerId,
      sellerName: sellerName ?? '',
      sellerAvatar: sellerAvatar ?? '',
      buyerId: buyerId ?? '',
      buyerName: buyerName ?? '',
      productId: productId,
      productName: productName ?? '',
      lastMessage: '',
      lastMessageAt: null,
      unreadCount: 0,
      isDraft: true,
    );
  }

  factory ConversationModel.fromJson(
    Map<String, dynamic> json, {
    String? currentUserId,
  }) {
    final id = _parseInt(
      _firstValue(json, const ['id', 'conversationId', 'chatId', 'roomId']),
    );
    final sellerId = _stringValue(json, const [
      'sellerId',
      'seller_id',
      'receiverId',
      'receiver_id',
      'otherUserId',
      'participantId',
      'userId',
    ]);
    final sellerName = _stringValue(json, const [
      'sellerName',
      'sellerFullName',
      'receiverName',
      'otherUserName',
      'participantName',
      'fullName',
      'name',
    ]);
    final sellerAvatar = _stringValue(json, const [
      'sellerAvatar',
      'receiverAvatar',
      'avatar',
      'profileImage',
      'image',
    ]);
    final buyerId = _stringValue(json, const [
      'buyerId',
      'buyer_id',
      'currentUserId',
      'initiatorId',
      'ownerId',
    ]);
    final buyerName = _stringValue(json, const ['buyerName', 'buyerFullName']);
    final productId = _nullableInt(
      _firstValue(json, const [
        'productId',
        'product_id',
        'itemId',
        'listingId',
      ]),
    );
    final productName = _stringValue(json, const [
      'productName',
      'listingName',
      'itemName',
      'title',
    ]);
    final lastMessage = _stringValue(json, const [
      'lastMessage',
      'last_message',
      'message',
      'preview',
    ]);
    final lastMessageAt = _nullableDateTime(
      _firstValue(json, const [
        'lastMessageAt',
        'last_message_at',
        'updatedAt',
        'createdAt',
      ]),
    );
    final unreadCount = _parseInt(
      _firstValue(json, const ['unreadCount', 'unread_count', 'pendingCount']),
    );
    final isDraft =
        _parseBool(_firstValue(json, const ['isDraft', 'draft'])) || id <= 0;

    return ConversationModel(
      id: id,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      buyerId: buyerId.isNotEmpty ? buyerId : (currentUserId ?? ''),
      buyerName: buyerName,
      productId: productId,
      productName: productName,
      lastMessage: lastMessage,
      lastMessageAt: lastMessageAt,
      unreadCount: unreadCount,
      isDraft: isDraft,
    );
  }

  static Object? _firstValue(Map<String, dynamic> json, List<String> keys) {
    for (final key in keys) {
      if (json.containsKey(key) && json[key] != null) {
        return json[key];
      }
    }
    return null;
  }

  static String _stringValue(Map<String, dynamic> json, List<String> keys) {
    final value = _firstValue(json, keys);
    return value?.toString().trim() ?? '';
  }

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static int? _nullableInt(dynamic value) {
    if (value == null) return null;
    final parsed = _parseInt(value);
    return parsed == 0 ? null : parsed;
  }

  static bool _parseBool(dynamic value) {
    if (value is bool) return value;
    final text = value?.toString().trim().toLowerCase();
    return text == 'true' || text == '1' || text == 'yes';
  }

  static DateTime? _nullableDateTime(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }
}
