import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../entities/chat_realtime_event.dart';
import '../entities/conversation_entity.dart';
import '../entities/message_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ConversationEntity>>> getConversations();
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required int conversationId,
  });
  Future<Either<Failure, ConversationEntity>> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  });
  Future<Either<Failure, MessageEntity>> sendMessage({
    required int conversationId,
    required String message,
    String? clientMessageId,
  });
  Future<Either<Failure, void>> reportMessage({
    required int messageId,
    String? reason,
  });
  Future<Either<Failure, void>> connectToChat();
  Stream<ChatRealtimeEvent> listenToMessages();
  Future<Either<Failure, void>> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  });
  Future<Either<Failure, void>> sendReadReceipt({required int messageId});
}
