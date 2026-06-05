import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/errors/failure.dart';

import '../repo/chat_repository.dart';

class ConnectToChatUseCase {
  final ChatRepository repository;

  ConnectToChatUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.connectToChat();
  }
}
