import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../entities/message_entity.dart';
import '../repo/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Future<Either<Failure, List<MessageEntity>>> call({
    required int conversationId,
  }) {
    return repository.getMessages(conversationId: conversationId);
  }
}
