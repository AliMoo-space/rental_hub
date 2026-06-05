part of 'conversations_cubit.dart';

enum ConversationsStatus { initial, loading, loaded, empty, error }

class ConversationsState extends Equatable {
  final ConversationsStatus status;
  final List<ConversationEntity> conversations;
  final String? errorMessage;

  const ConversationsState({
    this.status = ConversationsStatus.initial,
    this.conversations = const [],
    this.errorMessage,
  });

  ConversationsState copyWith({
    ConversationsStatus? status,
    List<ConversationEntity>? conversations,
    Object? errorMessage = _errorMessageMarker,
  }) {
    return ConversationsState(
      status: status ?? this.status,
      conversations: conversations ?? this.conversations,
      errorMessage: identical(errorMessage, _errorMessageMarker)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  static const Object _errorMessageMarker = Object();

  @override
  List<Object?> get props => [status, conversations, errorMessage];
}
