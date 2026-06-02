import 'package:equatable/equatable.dart';

import 'chat_message_status.dart';

class MessageEntity extends Equatable {
  final int id;
  final int conversationId;
  final String senderId;
  final String content;
  final DateTime timestamp;
  final ChatMessageStatus status;
  final bool isMine;
  final String senderName;
  final String senderAvatar;
  final String? clientMessageId;

  const MessageEntity({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.content,
    required this.timestamp,
    required this.status,
    required this.isMine,
    required this.senderName,
    required this.senderAvatar,
    this.clientMessageId,
  });

  MessageEntity copyWith({
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
    return MessageEntity(
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

  @override
  List<Object?> get props => [
    id,
    conversationId,
    senderId,
    content,
    timestamp,
    status,
    isMine,
    senderName,
    senderAvatar,
    clientMessageId,
  ];
}
