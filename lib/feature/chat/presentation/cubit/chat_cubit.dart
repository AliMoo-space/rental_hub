import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_message_status.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_realtime_event.dart';
import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';
import 'package:rental_hub/feature/chat/domain/entities/message_entity.dart';
import 'package:rental_hub/feature/chat/domain/usecases/connect_to_chat_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/create_or_get_conversation_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/get_messages_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/listen_to_messages_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/report_message_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/send_message_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/send_read_receipt_usecase.dart';
import 'package:rental_hub/feature/chat/domain/usecases/send_typing_indicator_usecase.dart';
import 'package:rental_hub/feature/chat/presentation/models/chat_route_args.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final CreateOrGetConversationUseCase createOrGetConversationUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendChatMessageUseCase sendChatMessageUseCase;
  final ReportMessageUseCase reportMessageUseCase;
  final ConnectToChatUseCase connectToChatUseCase;
  final ListenToMessagesUseCase listenToMessagesUseCase;
  final SendTypingIndicatorUseCase sendTypingIndicatorUseCase;
  final SendReadReceiptUseCase sendReadReceiptUseCase;
  final TokenStorageHelper tokenStorageHelper;

  StreamSubscription<ChatRealtimeEvent>? _subscription;
  Timer? _typingTimer;
  ChatRouteArgs? _routeArgs;
  String? _currentUserId;
  bool _disposed = false;

  ChatCubit(
    this.createOrGetConversationUseCase,
    this.getMessagesUseCase,
    this.sendChatMessageUseCase,
    this.reportMessageUseCase,
    this.connectToChatUseCase,
    this.listenToMessagesUseCase,
    this.sendTypingIndicatorUseCase,
    this.sendReadReceiptUseCase,
    this.tokenStorageHelper,
  ) : super(const ChatState());

  Future<void> initialize(ChatRouteArgs routeArgs) async {
    _routeArgs = routeArgs;
    emit(state.copyWith(status: ChatStatus.loading, errorMessage: null));

    _currentUserId = await tokenStorageHelper.getCurrentUserId();

    final ConversationEntity? conversation;
    if (routeArgs.hasConversationId) {
      conversation = ConversationEntity(
        id: routeArgs.conversationId!,
        sellerId: routeArgs.sellerId,
        sellerName: routeArgs.sellerName,
        sellerAvatar: routeArgs.sellerAvatar,
        buyerId: _currentUserId ?? '',
        buyerName: '',
        productId: routeArgs.productId,
        productName: routeArgs.productName,
        lastMessage: '',
        lastMessageAt: null,
        unreadCount: 0,
        isDraft: false,
      );
    } else {
      final conversationResult = await createOrGetConversationUseCase(
        sellerId: routeArgs.sellerId,
        sellerName: routeArgs.sellerName,
        sellerAvatar: routeArgs.sellerAvatar,
        productId: routeArgs.productId,
        productName: routeArgs.productName,
      );

      conversation = conversationResult.fold<ConversationEntity?>((failure) {
        emit(
          state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.errMessage,
          ),
        );
        return null;
      }, (value) => value);
    }

    if (conversation == null) {
      return;
    }

    List<MessageEntity> messages = const [];
    if (conversation.id > 0) {
      final messagesResult = await getMessagesUseCase(
        conversationId: conversation.id,
      );

      messages = messagesResult.fold((failure) {
        emit(
          state.copyWith(
            status: ChatStatus.error,
            conversation: conversation,
            errorMessage: failure.errMessage,
          ),
        );
        return const <MessageEntity>[];
      }, (value) => value);
    }

    final connectionResult = await connectToChatUseCase();
    final isConnected = connectionResult.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ChatStatus.error,
            conversation: conversation,
            messages: messages,
            isConnected: false,
            errorMessage: failure.errMessage,
          ),
        );
        return false;
      },
      (_) {
        _subscription?.cancel();
        _subscription = listenToMessagesUseCase().listen(
          _handleRealtimeEvent,
          onError: (Object error, StackTrace stackTrace) {
            if (_disposed) return;
            emit(
              state.copyWith(
                status: ChatStatus.error,
                errorMessage: error.toString(),
              ),
            );
          },
        );
        return true;
      },
    );

    emit(
      state.copyWith(
        status: ChatStatus.loaded,
        conversation: conversation,
        messages: messages,
        isConnected: isConnected,
        isSending: false,
        isTyping: false,
        typingUserName: null,
        errorMessage: null,
      ),
    );

    await _markUnreadMessagesAsRead(messages);
  }

  Future<void> sendMessage(String text) async {
    final current = state;
    final trimmed = text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final conversation = await _ensureActiveConversation();
    if (conversation == null || conversation.id <= 0) {
      emit(
        current.copyWith(
          status: ChatStatus.error,
          errorMessage: 'Unable to start conversation. Please try again.',
        ),
      );
      return;
    }

    final clientMessageId = 'client-${DateTime.now().microsecondsSinceEpoch}';
    final optimisticMessage = MessageEntity(
      id: _buildTemporaryMessageId(),
      conversationId: conversation.id,
      senderId: _currentUserId ?? '',
      content: trimmed,
      timestamp: DateTime.now(),
      status: ChatMessageStatus.sent,
      isMine: true,
      senderName: '',
      senderAvatar: '',
      clientMessageId: clientMessageId,
    );

    emit(
      current.copyWith(
        status: ChatStatus.messageSent,
        messages: [...current.messages, optimisticMessage],
        isSending: true,
        errorMessage: null,
      ),
    );

    final result = await sendChatMessageUseCase(
      conversationId: conversation.id,
      message: trimmed,
      clientMessageId: clientMessageId,
    );

    result.fold(
      (failure) {
        emit(
          current.copyWith(
            status: ChatStatus.error,
            messages: _removeMessageByClientId(state.messages, clientMessageId),
            isSending: false,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (message) {
        emit(
          state.copyWith(
            status: ChatStatus.loaded,
            messages: _replaceMessage(
              state.messages,
              message.copyWith(status: ChatMessageStatus.delivered),
            ),
            isSending: false,
          ),
        );
      },
    );

    await sendTypingIndicatorUseCase(
      conversationId: conversation.id,
      isTyping: false,
    );
  }

  Future<void> reportMessage({required int messageId, String? reason}) async {
    final result = await reportMessageUseCase(
      messageId: messageId,
      reason: reason,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.errMessage,
          ),
        );
      },
      (_) {
        emit(state.copyWith(status: ChatStatus.loaded, errorMessage: null));
      },
    );
  }

  Future<void> handleTextChanged(String value) async {
    final conversation = state.conversation;
    if (conversation == null || conversation.id <= 0) {
      return;
    }

    _typingTimer?.cancel();

    if (value.trim().isEmpty) {
      await sendTypingIndicatorUseCase(
        conversationId: conversation.id,
        isTyping: false,
      );
      emit(state.copyWith(status: ChatStatus.typingUpdated, isTyping: false));
      return;
    }

    _typingTimer = Timer(const Duration(milliseconds: 400), () {
      if (_disposed) return;
      sendTypingIndicatorUseCase(
        conversationId: conversation.id,
        isTyping: true,
      );
      emit(state.copyWith(status: ChatStatus.typingUpdated, isTyping: true));
    });
  }

  Future<void> markConversationAsRead() async {
    final messages = state.messages;
    for (final message in messages) {
      if (!message.isMine && message.status != ChatMessageStatus.read) {
        await sendReadReceiptUseCase(messageId: message.id);
      }
    }
    emit(state.copyWith(status: ChatStatus.messageReadUpdated));
  }

  void _handleRealtimeEvent(ChatRealtimeEvent event) {
    if (_disposed) {
      return;
    }

    switch (event) {
      case ChatMessageReceivedEvent(:final message):
        final normalizedMessage = _normalizeIncomingMessage(message);
        final existing = _findMatchingLocalMessage(normalizedMessage);

        final updatedMessages = existing == null
            ? [...state.messages, normalizedMessage]
            : _replaceMessage(
                state.messages,
                normalizedMessage.copyWith(status: ChatMessageStatus.delivered),
              );

        emit(
          state.copyWith(
            status: ChatStatus.messageReceived,
            messages: _sortMessages(updatedMessages),
            isTyping: false,
            typingUserName: null,
          ),
        );

        if (!normalizedMessage.isMine) {
          unawaited(sendReadReceiptUseCase(messageId: normalizedMessage.id));
        }
      case ChatTypingEvent(
        :final conversationId,
        :final senderId,
        :final senderName,
        :final isTyping,
      ):
        final currentConversation = state.conversation;
        if (currentConversation == null ||
            (conversationId > 0 &&
                currentConversation.id > 0 &&
                conversationId != currentConversation.id)) {
          return;
        }

        if (senderId.isNotEmpty && senderId == _currentUserId) {
          return;
        }

        emit(
          state.copyWith(
            status: ChatStatus.typingUpdated,
            isTyping: isTyping,
            typingUserName: senderName.isNotEmpty
                ? senderName
                : currentConversation?.sellerName,
          ),
        );
      case ChatReadReceiptEvent(:final messageId, :final status):
        emit(
          state.copyWith(
            status: ChatStatus.messageReadUpdated,
            messages: _updateMessageStatus(
              state.messages,
              messageId: messageId,
              status: status,
            ),
          ),
        );
    }
  }

  Future<ConversationEntity?> _ensureActiveConversation() async {
    final conversation = state.conversation;
    if (conversation == null) {
      return null;
    }

    if (conversation.id > 0 && !conversation.isDraft) {
      return conversation;
    }

    final routeArgs = _routeArgs;
    if (routeArgs == null || !routeArgs.hasSeller) {
      return conversation.id > 0 ? conversation : null;
    }

    final result = await createOrGetConversationUseCase(
      sellerId: routeArgs.sellerId,
      sellerName: routeArgs.sellerName,
      sellerAvatar: routeArgs.sellerAvatar,
      productId: routeArgs.productId,
      productName: routeArgs.productName,
    );

    return result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ChatStatus.error,
            errorMessage: failure.errMessage,
          ),
        );
        return null;
      },
      (resolved) {
        emit(state.copyWith(conversation: resolved));
        return resolved;
      },
    );
  }

  Future<void> _markUnreadMessagesAsRead(List<MessageEntity> messages) async {
    for (final message in messages) {
      if (!message.isMine && message.status != ChatMessageStatus.read) {
        await sendReadReceiptUseCase(messageId: message.id);
      }
    }
  }

  MessageEntity _normalizeIncomingMessage(MessageEntity message) {
    final currentUserId = _currentUserId;
    final isMine = currentUserId != null && currentUserId.isNotEmpty
        ? message.senderId == currentUserId
        : message.isMine;

    return message.copyWith(
      isMine: isMine,
      status: isMine && message.status == ChatMessageStatus.sent
          ? ChatMessageStatus.delivered
          : message.status,
    );
  }

  MessageEntity? _findMatchingLocalMessage(MessageEntity incoming) {
    final localClientId = incoming.clientMessageId;
    if (localClientId != null && localClientId.isNotEmpty) {
      for (final message in state.messages) {
        if (message.clientMessageId == localClientId) {
          return message;
        }
      }
    }

    for (final message in state.messages.reversed) {
      if (message.isMine &&
          message.content == incoming.content &&
          message.senderId == incoming.senderId &&
          incoming.timestamp.difference(message.timestamp).inSeconds.abs() <=
              10) {
        return message;
      }
    }

    return null;
  }

  List<MessageEntity> _replaceMessage(
    List<MessageEntity> messages,
    MessageEntity message,
  ) {
    final index = messages.indexWhere((item) {
      if (message.clientMessageId != null &&
          item.clientMessageId == message.clientMessageId) {
        return true;
      }
      return item.id == message.id;
    });

    if (index == -1) {
      return [...messages, message];
    }

    final updated = [...messages];
    updated[index] = message;
    return _sortMessages(updated);
  }

  List<MessageEntity> _removeMessageByClientId(
    List<MessageEntity> messages,
    String clientMessageId,
  ) {
    return messages
        .where((message) => message.clientMessageId != clientMessageId)
        .toList();
  }

  List<MessageEntity> _updateMessageStatus(
    List<MessageEntity> messages, {
    required int messageId,
    required ChatMessageStatus status,
  }) {
    return messages.map((message) {
      if (message.id != messageId) {
        return message;
      }
      return message.copyWith(status: status);
    }).toList();
  }

  List<MessageEntity> _sortMessages(List<MessageEntity> messages) {
    final sorted = [...messages];
    sorted.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return sorted;
  }

  int _buildTemporaryMessageId() {
    final seed = DateTime.now().microsecondsSinceEpoch % 2147483647;
    return seed == 0 ? -1 : -seed;
  }

  @override
  Future<void> close() async {
    _disposed = true;
    _typingTimer?.cancel();
    await _subscription?.cancel();
    return super.close();
  }
}
