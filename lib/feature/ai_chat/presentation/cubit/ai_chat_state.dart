import 'package:equatable/equatable.dart';
import 'package:rental_hub/feature/ai_chat/presentation/models/chat_message_model.dart';

class AiChatState extends Equatable {
  final List<ChatMessageModel> messages;
  final bool isSending;
  final String? errorMessage;

  const AiChatState({
    this.messages = const [],
    this.isSending = false,
    this.errorMessage,
  });

  static const Object _errorMarker = Object();

  AiChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isSending,
    Object? errorMessage = _errorMarker,
  }) {
    return AiChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: identical(errorMessage, _errorMarker)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  @override
  List<Object?> get props => [messages, isSending, errorMessage];
}
