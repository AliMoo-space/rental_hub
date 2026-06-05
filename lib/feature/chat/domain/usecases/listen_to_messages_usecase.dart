import '../entities/chat_realtime_event.dart';
import '../repo/chat_repository.dart';

class ListenToMessagesUseCase {
  final ChatRepository repository;

  ListenToMessagesUseCase(this.repository);

  Stream<ChatRealtimeEvent> call() {
    return repository.listenToMessages();
  }
}
