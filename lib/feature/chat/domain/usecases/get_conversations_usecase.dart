import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../entities/conversation_entity.dart';
import '../repo/chat_repository.dart';

class GetConversationsUseCase {
  final ChatRepository repository;

  GetConversationsUseCase(this.repository);

  Future<Either<Failure, List<ConversationEntity>>> call() {
    return repository.getConversations();
  }
}
