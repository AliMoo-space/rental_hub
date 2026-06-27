import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class ReportMessageUseCase {
  final ChatRepository repository;

  ReportMessageUseCase(this.repository);

  Future<Either<Failure, void>> call({required int messageId, String? reason}) {
    return repository.reportMessage(messageId: messageId, reason: reason);
  }
}
