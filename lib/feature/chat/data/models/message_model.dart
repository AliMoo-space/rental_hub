import 'package:rental_hub/feature/chat/domain/entities/chat_message_status.dart';
import 'package:rental_hub/feature/chat/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.content,
    required super.timestamp,
    required super.status,
    required super.isMine,
    required super.senderName,
    required super.senderAvatar,
    super.clientMessageId,
  });

  factory MessageModel.fromJson(
    Map<String, dynamic> json, {
    String? currentUserId,
  }) {
    final senderId = _stringValue(json, const [
      'senderId',
      'sender_id',
      'fromUserId',
      'userId',
      'ownerId',
    ]);
    final content = _stringValue(json, const [
      'content',
      'text',
      'body',
      'message',
      'messageText',
    ]);
    final conversationId = _parseInt(
      _firstValue(json, const [
        'conversationId',
        'conversation_id',
        'chatId',
        'roomId',
      ]),
    );
    final id = _parseInt(
      _firstValue(json, const ['id', 'messageId', 'message_id']),
    );
    final timestamp =
        _nullableDateTime(
          _firstValue(json, const [
            'timestamp',
            'createdAt',
            'sentAt',
            'date',
            'time',
          ]),
        ) ??
        DateTime.now();
    final status = ChatMessageStatusX.fromValue(
      _firstValue(json, const [
        'status',
        'messageStatus',
        'deliveryStatus',
        'state',
      ]),
    );
    final senderName = _stringValue(json, const [
      'senderName',
      'fullName',
      'name',
      'userName',
    ]);
    final senderAvatar = _stringValue(json, const [
      'senderAvatar',
      'avatar',
      'profileImage',
      'image',
    ]);
    final clientMessageId = _stringValue(json, const [
      'clientMessageId',
      'client_message_id',
      'localId',
      'tempId',
    ]);
    final isMineValue = _firstValue(json, const ['isMine', 'mine', 'sentByMe']);
    final isMine = isMineValue is bool
        ? isMineValue
        : currentUserId != null && currentUserId.isNotEmpty
        ? senderId == currentUserId
        : false;

    return MessageModel(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      content: content,
      timestamp: timestamp,
      status: _inferStatus(json, status),
      isMine: isMine,
      senderName: senderName,
      senderAvatar: senderAvatar,
      clientMessageId: clientMessageId.isEmpty ? null : clientMessageId,
    );
  }

  MessageModel copyWith({
    int? id,
    int? conversationId,
    String? senderId,
    String? content,
    DateTime? timestamp,
    ChatMessageStatus? status,
    bool? isMine,
    String? senderName,
    String? senderAvatar,
    Object? clientMessageId = _clientMessageIdMarker,
  }) {
    return MessageModel(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      isMine: isMine ?? this.isMine,
      senderName: senderName ?? this.senderName,
      senderAvatar: senderAvatar ?? this.senderAvatar,
      clientMessageId: identical(clientMessageId, _clientMessageIdMarker)
          ? this.clientMessageId
          : clientMessageId as String?,
    );
  }

  static const Object _clientMessageIdMarker = Object();

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

  static DateTime? _nullableDateTime(dynamic value) {
    if (value == null) return null;
    final text = value.toString().trim();
    if (text.isEmpty) return null;
    return DateTime.tryParse(text);
  }

  static ChatMessageStatus _inferStatus(
    Map<String, dynamic> json,
    ChatMessageStatus status,
  ) {
    final delivered = _firstValue(json, const ['isDelivered', 'delivered']);
    final read = _firstValue(json, const ['isRead', 'read']);

    if (_toBool(read)) {
      return ChatMessageStatus.read;
    }
    if (_toBool(delivered)) {
      return ChatMessageStatus.delivered;
    }
    return status;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) return value;
    final text = value?.toString().trim().toLowerCase();
    return text == 'true' || text == '1' || text == 'yes';
  }
}
