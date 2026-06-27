import 'dart:async';

import 'package:rental_hub/core/databases/api/end_points.dart';
import 'package:rental_hub/core/utils/response_parser.dart';
import 'package:rental_hub/feature/chat/data/models/conversation_model.dart';
import 'package:rental_hub/feature/chat/data/models/message_model.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_message_status.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_realtime_event.dart';
import 'package:signalr_netcore/signalr_client.dart';

abstract class ChatSignalRDataSource {
  Future<void> connect(String token);
  Future<void> disconnect();
  Future<ConversationModel> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  });
  Future<void> sendMessage({
    required int conversationId,
    required String message,
  });
  Future<void> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  });
  Future<void> sendReadReceipt({required int messageId});
  Future<void> updateMessageStatus({
    required int messageId,
    required ChatMessageStatus status,
  });
  Stream<ChatRealtimeEvent> get events;
}

class ChatSignalRDataSourceImpl implements ChatSignalRDataSource {
  HubConnection? _connection;
  final StreamController<ChatRealtimeEvent> _eventsController =
      StreamController<ChatRealtimeEvent>.broadcast();
  bool _manualDisconnect = false;
  bool _handlersRegistered = false;

  @override
  Stream<ChatRealtimeEvent> get events => _eventsController.stream;

  @override
  Future<void> connect(String token) async {
    if (_connection != null &&
        _connection!.state == HubConnectionState.Connected) {
      return;
    }

    if (_connection != null &&
        _connection!.state != HubConnectionState.Disconnected) {
      await disconnect();
    }

    _manualDisconnect = false;
    _handlersRegistered = false;
    _connection = HubConnectionBuilder()
        .withUrl(
          '${EndPoints.baseUrl}${EndPoints.chatHubEndpoint}',
          options: HttpConnectionOptions(
            accessTokenFactory: () async => token,
            logMessageContent: false,
          ),
        )
        .withAutomaticReconnect()
        .build();

    _registerHandlers();
    await _connection!.start();
  }

  @override
  Future<void> disconnect() async {
    final connection = _connection;
    if (connection == null) {
      return;
    }

    _manualDisconnect = true;
    try {
      await connection.stop();
    } finally {
      _connection = null;
      _manualDisconnect = false;
    }
  }

  @override
  Future<ConversationModel> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  }) async {
    final connection = _requireConnection();
    final args = <Object>[sellerId, if (productId != null) productId];

    final result = await connection.invoke(
      'CreateOrGetConversation',
      args: args,
    );
    final map = _toMap(result);
    if (map != null) {
      return ConversationModel.fromJson(map);
    }

    return ConversationModel.draft(
      sellerId: sellerId,
      sellerName: sellerName,
      sellerAvatar: sellerAvatar,
      productId: productId,
      productName: productName,
    );
  }

  @override
  Future<void> sendMessage({
    required int conversationId,
    required String message,
  }) async {
    final connection = _requireConnection();
    await connection.invoke('SendMessage', args: [conversationId, message]);
  }

  @override
  Future<void> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  }) async {
    final connection = _requireConnection();
    await connection.invoke('Typing', args: [conversationId, isTyping]);
  }

  @override
  Future<void> sendReadReceipt({required int messageId}) async {
    final connection = _requireConnection();
    await connection.invoke('MarkAsRead', args: [messageId]);
  }

  @override
  Future<void> updateMessageStatus({
    required int messageId,
    required ChatMessageStatus status,
  }) async {
    if (status == ChatMessageStatus.read) {
      await sendReadReceipt(messageId: messageId);
    }
  }

  void _registerHandlers() {
    if (_connection == null || _handlersRegistered) {
      return;
    }

    _handlersRegistered = true;

    _connection!.on('ReceiveMessage', _handleReceiveMessage);
    _connection!.on('UserTyping', _handleTyping);
    _connection!.on('MessageRead', _handleReadReceipt);
    _connection!.onclose(({Exception? error}) {
      if (_manualDisconnect) {
        return;
      }
      _eventsController.addError(error ?? Exception('Chat connection closed'));
    });
  }

  void _handleReceiveMessage(List<Object?>? arguments) {
    final payload = _extractPayload(arguments);
    final map = _toMap(payload);
    if (map == null) {
      return;
    }

    final message = MessageModel.fromJson(map);
    _eventsController.add(ChatMessageReceivedEvent(message));
  }

  void _handleTyping(List<Object?>? arguments) {
    final payload = _extractPayload(arguments);
    final map = _toMap(payload);
    if (map != null) {
      final conversationId = _parseInt(
        _readFirst(map, const ['conversationId', 'conversation_id', 'chatId']),
        defaultValue: 0,
      );
      final senderId = _readFirst(map, const [
        'senderId',
        'sender_id',
        'userId',
        'fromUserId',
      ]);
      final senderName =
          _readFirst(map, const ['senderName', 'fullName', 'name']) ?? '';
      final isTyping = _parseBool(
        _readFirst(map, const ['isTyping', 'typing', 'value']),
        defaultValue: true,
      );
      _eventsController.add(
        ChatTypingEvent(
          conversationId: conversationId,
          senderId: senderId ?? '',
          senderName: senderName,
          isTyping: isTyping,
        ),
      );
      return;
    }

    final values = arguments ?? const [];
    if (values.isEmpty) return;

    final conversationId = _parseInt(
      values.elementAtOrNull(0),
      defaultValue: 0,
    );
    final senderId = values.elementAtOrNull(1)?.toString() ?? '';
    final isTyping = values.length > 2
        ? _parseBool(values.elementAtOrNull(2), defaultValue: true)
        : true;
    _eventsController.add(
      ChatTypingEvent(
        conversationId: conversationId,
        senderId: senderId,
        senderName: '',
        isTyping: isTyping,
      ),
    );
  }

  void _handleReadReceipt(List<Object?>? arguments) {
    final payload = _extractPayload(arguments);
    final map = _toMap(payload);
    if (map != null) {
      final messageId = _parseInt(
        _readFirst(map, const ['messageId', 'message_id', 'id']),
        defaultValue: 0,
      );
      final conversationId = _parseInt(
        _readFirst(map, const ['conversationId', 'conversation_id', 'chatId']),
        defaultValue: 0,
      );
      final status = ChatMessageStatusX.fromValue(
        _readFirst(map, const ['status', 'messageStatus', 'state']),
      );
      _eventsController.add(
        ChatReadReceiptEvent(
          messageId: messageId,
          conversationId: conversationId,
          status: status,
        ),
      );
      return;
    }

    final values = arguments ?? const [];
    if (values.isEmpty) return;

    final messageId = _parseInt(values.elementAtOrNull(0), defaultValue: 0);
    final status = values.length > 1
        ? ChatMessageStatusX.fromValue(values.elementAtOrNull(1))
        : ChatMessageStatus.read;
    _eventsController.add(
      ChatReadReceiptEvent(
        messageId: messageId,
        conversationId: 0,
        status: status,
      ),
    );
  }

  dynamic _extractPayload(List<Object?>? arguments) {
    if (arguments == null || arguments.isEmpty) {
      return null;
    }

    if (arguments.length == 1) {
      return arguments.first;
    }

    return arguments;
  }

  Map<String, dynamic>? _toMap(dynamic payload) {
    if (payload is Map) {
      return Map<String, dynamic>.from(
        ResponseParser.extractDataPayload(payload),
      );
    }

    return null;
  }

  String? _readFirst(Map<String, dynamic> map, List<String> keys) {
    for (final key in keys) {
      final value = map[key];
      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }

  int _parseInt(dynamic value, {required int defaultValue}) {
    if (value is int) return value;
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? defaultValue;
  }

  bool _parseBool(dynamic value, {required bool defaultValue}) {
    if (value is bool) return value;
    final text = value?.toString().trim().toLowerCase();
    if (text == null || text.isEmpty) return defaultValue;
    return text == 'true' || text == '1' || text == 'yes';
  }

  HubConnection _requireConnection() {
    final connection = _connection;
    if (connection == null) {
      throw StateError('Chat connection is not initialized');
    }
    return connection;
  }
}

extension _IterableElementAtOrNull<E> on Iterable<E> {
  E? elementAtOrNull(int index) {
    if (index < 0) {
      return null;
    }

    var currentIndex = 0;
    for (final element in this) {
      if (currentIndex == index) {
        return element;
      }
      currentIndex++;
    }
    return null;
  }
}
