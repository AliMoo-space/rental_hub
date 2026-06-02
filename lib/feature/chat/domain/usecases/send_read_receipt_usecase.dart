import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class SendReadReceiptUseCase {
  final ChatRepository repository;

  SendReadReceiptUseCase(this.repository);

  Future<Either<Failure, void>> call({required int messageId}) {
    return repository.sendReadReceipt(messageId: messageId);
  }
}import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class SendReadReceiptUseCase {
  final ChatRepository repository;

  SendReadReceiptUseCase(this.repository);

  Future<Either<Failure, void>> call({required int messageId}) {
    return repository.sendReadReceipt(messageId: messageId);
  }
}