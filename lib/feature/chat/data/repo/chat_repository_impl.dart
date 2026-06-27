import 'package:dartz/dartz.dart';
import 'package:rental_hub/core/databases/cache/token_storage_helper.dart';
import 'package:rental_hub/core/errors/error_handling.dart';
import 'package:rental_hub/core/errors/failure.dart';
import 'package:rental_hub/feature/chat/data/datasources/chat_remote_data_source.dart';
import 'package:rental_hub/feature/chat/data/datasources/chat_signalr_data_source.dart';
import 'package:rental_hub/feature/chat/data/models/conversation_model.dart';
import 'package:rental_hub/feature/chat/data/models/message_model.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_message_status.dart';
import 'package:rental_hub/feature/chat/domain/entities/chat_realtime_event.dart';
import 'package:rental_hub/feature/chat/domain/entities/conversation_entity.dart';
import 'package:rental_hub/feature/chat/domain/entities/message_entity.dart';
import 'package:rental_hub/feature/chat/domain/repo/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatSignalRDataSource signalRDataSource;
  final TokenStorageHelper tokenStorageHelper;

  ChatRepositoryImpl({
    required this.remoteDataSource,
    required this.signalRDataSource,
    required this.tokenStorageHelper,
  });

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final currentUserId = await tokenStorageHelper.getCurrentUserId();
      final response = await remoteDataSource.getConversations();
      return Right(
        response
            .map(
              (conversation) => _mapConversation(conversation, currentUserId),
            )
            .toList(),
      );
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to load conversations: $e'));
    }
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> getMessages({
    required int conversationId,
  }) async {
    try {
      final currentUserId = await tokenStorageHelper.getCurrentUserId();
      final response = await remoteDataSource.getMessages(
        conversationId: conversationId,
      );
      return Right(
        response.map((message) => _mapMessage(message, currentUserId)).toList(),
      );
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to load messages: $e'));
    }
  }

  @override
  Future<Either<Failure, ConversationEntity>> createOrGetConversation({
    required String sellerId,
    String? sellerName,
    String? sellerAvatar,
    int? productId,
    String? productName,
  }) async {
    try {
      final currentUserId = await tokenStorageHelper.getCurrentUserId();
      var conversation = await remoteDataSource.createOrGetConversation(
        sellerId: sellerId,
        sellerName: sellerName,
        sellerAvatar: sellerAvatar,
        productId: productId,
        productName: productName,
      );

      if (conversation.isDraft) {
        final token = await tokenStorageHelper.getAccessToken();
        if (token == null || token.trim().isEmpty) {
          return const Left(
            Failure(errMessage: 'Missing authentication token'),
          );
        }
        await signalRDataSource.connect(token);
        conversation = await signalRDataSource.createOrGetConversation(
          sellerId: sellerId,
          sellerName: sellerName,
          sellerAvatar: sellerAvatar,
          productId: productId,
          productName: productName,
        );
      }

      return Right(_mapConversation(conversation, currentUserId));
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to prepare conversation: $e'));
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendMessage({
    required int conversationId,
    required String message,
    String? clientMessageId,
  }) async {
    try {
      await signalRDataSource.sendMessage(
        conversationId: conversationId,
        message: message,
      );

      final currentUserId = await tokenStorageHelper.getCurrentUserId();
      final now = DateTime.now();
      final tempId = _buildTempId(now.microsecondsSinceEpoch);

      return Right(
        MessageModel(
          id: tempId,
          conversationId: conversationId,
          senderId: currentUserId ?? '',
          content: message,
          timestamp: now,
          status: ChatMessageStatus.sent,
          isMine: true,
          senderName: '',
          senderAvatar: '',
          clientMessageId: clientMessageId ?? 'client-$tempId',
        ),
      );
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to send message: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> reportMessage({
    required int messageId,
    String? reason,
  }) async {
    try {
      await remoteDataSource.reportMessage(
        messageId: messageId,
        reason: reason,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to report message: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> connectToChat() async {
    try {
      final token = await tokenStorageHelper.getAccessToken();
      if (token == null || token.trim().isEmpty) {
        return const Left(Failure(errMessage: 'Missing authentication token'));
      }
      await signalRDataSource.connect(token);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to connect chat: $e'));
    }
  }

  @override
  Stream<ChatRealtimeEvent> listenToMessages() {
    return signalRDataSource.events;
  }

  @override
  Future<Either<Failure, void>> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  }) async {
    try {
      await signalRDataSource.sendTypingIndicator(
        conversationId: conversationId,
        isTyping: isTyping,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to send typing indicator: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> sendReadReceipt({
    required int messageId,
  }) async {
    try {
      await signalRDataSource.sendReadReceipt(messageId: messageId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        Failure(
          statusCode: e.errorModel.statusCode,
          errMessage: e.errorModel.firstErrorMessage,
        ),
      );
    } catch (e) {
      return Left(Failure(errMessage: 'Failed to send read receipt: $e'));
    }
  }

  ConversationEntity _mapConversation(
    ConversationEntity conversation,
    String? currentUserId,
  ) {
    if (conversation is ConversationModel) {
      return ConversationModel(
        id: conversation.id,
        sellerId: conversation.sellerId,
        sellerName: conversation.sellerName,
        sellerAvatar: conversation.sellerAvatar,
        buyerId: conversation.buyerId.isNotEmpty
            ? conversation.buyerId
            : (currentUserId ?? ''),
        buyerName: conversation.buyerName,
        productId: conversation.productId,
        productName: conversation.productName,
        lastMessage: conversation.lastMessage,
        lastMessageAt: conversation.lastMessageAt,
        unreadCount: conversation.unreadCount,
        isDraft: conversation.isDraft,
      );
    }

    return conversation.copyWith(
      buyerId: conversation.buyerId.isNotEmpty
          ? conversation.buyerId
          : (currentUserId ?? ''),
    );
  }

  MessageEntity _mapMessage(MessageEntity message, String? currentUserId) {
    final isMine = currentUserId != null && currentUserId.isNotEmpty
        ? message.senderId == currentUserId
        : message.isMine;

    if (message is MessageModel) {
      return message.copyWith(isMine: isMine);
    }

    return message.copyWith(isMine: isMine);
  }

  int _buildTempId(int seed) {
    final value = seed % 2147483647;
    return value == 0 ? -1 : -value;
  }
}
