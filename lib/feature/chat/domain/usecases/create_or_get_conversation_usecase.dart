import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../entities/conversation_entity.dart';
import '../repo/chat_repository.dart';

class CreateOrGetConversationUseCase {
  final ChatRepository repository;

  CreateOrGetConversationUseCase(this.repository);

  Future<Either<Failure, ConversationEntity>> call({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  }) {
    return repository.createOrGetConversation(
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      productId: productId,
      productName: productName,
    );
  }
}
