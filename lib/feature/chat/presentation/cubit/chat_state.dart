part of 'chat_cubit.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error,
  messageSent,
  messageReceived,
  typingUpdated,
  messageReadUpdated,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final ConversationEntity? conversation;
  final List<MessageEntity> messages;
  final bool isConnected;
  final bool isSending;
  final bool isTyping;
  final String? typingUserName;
  final String? errorMessage;

  const ChatState({
    this.status = ChatStatus.initial,
    this.conversation,
    this.messages = const [],
    this.isConnected = false,
    this.isSending = false,
    this.isTyping = false,
    this.typingUserName,
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStatus? status,
    ConversationEntity? conversation,
    List<MessageEntity>? messages,
    bool? isConnected,
    bool? isSending,
    bool? isTyping,
    Object? typingUserName = _typingUserNameMarker,
    Object? errorMessage = _errorMessageMarker,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      isSending: isSending ?? this.isSending,
      isTyping: isTyping ?? this.isTyping,
      typingUserName: identical(typingUserName, _typingUserNameMarker)
          ? this.typingUserName
          : typingUserName as String?,
      errorMessage: identical(errorMessage, _errorMessageMarker)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  static const Object _typingUserNameMarker = Object();
  static const Object _errorMessageMarker = Object();

  @override
  List<Object?> get props => [
    status,
    conversation,
    messages,
    isConnected,
    isSending,
    isTyping,
    typingUserName,
    errorMessage,
  ];
}part of 'chat_cubit.dart';

enum ChatStatus {
  initial,
  loading,
  loaded,
  error,
  messageSent,
  messageReceived,
  typingUpdated,
  messageReadUpdated,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final ConversationEntity? conversation;
  final List<MessageEntity> messages;
  final bool isConnected;
  final bool isSending;
  final bool isTyping;
  final String? typingUserName;
  final String? errorMessage;

  const ChatState({
    this.status = ChatStatus.initial,
    this.conversation,
    this.messages = const [],
    this.isConnected = false,
    this.isSending = false,
    this.isTyping = false,
    this.typingUserName,
    this.errorMessage,
  });

  ChatState copyWith({
    ChatStatus? status,
    ConversationEntity? conversation,
    List<MessageEntity>? messages,
    bool? isConnected,
    bool? isSending,
    bool? isTyping,
    Object? typingUserName = _typingUserNameMarker,
    Object? errorMessage = _errorMessageMarker,
  }) {
    return ChatState(
      status: status ?? this.status,
      conversation: conversation ?? this.conversation,
      messages: messages ?? this.messages,
      isConnected: isConnected ?? this.isConnected,
      isSending: isSending ?? this.isSending,
      isTyping: isTyping ?? this.isTyping,
      typingUserName: identical(typingUserName, _typingUserNameMarker)
          ? this.typingUserName
          : typingUserName as String?,
      errorMessage: identical(errorMessage, _errorMessageMarker)
          ? this.errorMessage
          : errorMessage as String?,
    );
  }

  static const Object _typingUserNameMarker = Object();
  static const Object _errorMessageMarker = Object();

  @override
  List<Object?> get props => [
    status,
    conversation,
    messages,
    isConnected,
    isSending,
    isTyping,
    typingUserName,
    errorMessage,
  ];
}