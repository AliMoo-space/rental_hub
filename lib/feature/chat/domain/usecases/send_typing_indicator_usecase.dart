import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class SendTypingIndicatorUseCase {
  final ChatRepository repository;

  SendTypingIndicatorUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int conversationId,
    required bool isTyping,
  }) {
    return repository.sendTypingIndicator(
      conversationId: conversationId,
      isTyping: isTyping,
    );
  }
}import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class SendTypingIndicatorUseCase {
  final ChatRepository repository;

  SendTypingIndicatorUseCase(this.repository);

  Future<Either<Failure, void>> call({
    required int conversationId,
    required bool isTyping,
  }) {
    return repository.sendTypingIndicator(
      conversationId: conversationId,
      isTyping: isTyping,
    );
  }
}