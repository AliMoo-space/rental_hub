import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../entities/message_entity.dart';
import '../repo/chat_repository.dart';

class SendChatMessageUseCase {
  final ChatRepository repository;

  SendChatMessageUseCase(this.repository);

  Future<Either<Failure, MessageEntity>> call({
    required int conversationId,
    required String message,
    String? clientMessageId,
  }) {
    return repository.sendMessage(
      conversationId: conversationId,
      message: message,
      clientMessageId: clientMessageId,
    );
  }
}
