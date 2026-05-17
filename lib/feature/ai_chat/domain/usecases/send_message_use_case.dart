import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_entity.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';
import 'package:rental_hub/feature/ai_chat/domain/repo/ai_chat_repo.dart';

class SendMessageUseCase {
  final AiChatRepo aiChatRepo;

  SendMessageUseCase(this.aiChatRepo);

  Future<Either<Failure, AiChatEntity>> call(AiChatParams params) {
    return aiChatRepo.sendMessage(params);
  }
}
