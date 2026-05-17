import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_entity.dart';
import 'package:rental_hub/feature/ai_chat/domain/entities/ai_chat_params.dart';

abstract class AiChatRepo {
  Future<Either<Failure, AiChatEntity>> sendMessage(AiChatParams params);
}
