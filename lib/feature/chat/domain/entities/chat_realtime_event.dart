import 'package:equatable/equatable.dart';

import 'chat_message_status.dart';
import 'message_entity.dart';

sealed class ChatRealtimeEvent extends Equatable {
  const ChatRealtimeEvent();

  @override
  List<Object?> get props => [];
}

final class ChatMessageReceivedEvent extends ChatRealtimeEvent {
  final MessageEntity message;

  const ChatMessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}

final class ChatTypingEvent extends ChatRealtimeEvent {
  final int conversationId;
  final String senderId;
  final String senderName;
  final bool isTyping;

  const ChatTypingEvent({
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    required this.isTyping,
  });

  @override
  List<Object?> get props => [conversationId, senderId, senderName, isTyping];
}

final class ChatReadReceiptEvent extends ChatRealtimeEvent {
  final int messageId;
  final int conversationId;
  final ChatMessageStatus status;

  const ChatReadReceiptEvent({
    required this.messageId,
    required this.conversationId,
    required this.status,
  });

  @override
  List<Object?> get props => [messageId, conversationId, status];
}
