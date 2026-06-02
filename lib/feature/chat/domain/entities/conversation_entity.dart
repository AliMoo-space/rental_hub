import 'package:equatable/equatable.dart';

class ConversationEntity extends Equatable {
  final int id;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final String buyerId;
  final String buyerName;
  final int? productId;
  final String productName;
  final String lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isDraft;

  const ConversationEntity({
    required this.id,
    required this.sellerId,
    required this.sellerName,
    required this.sellerAvatar,
    required this.buyerId,
    required this.buyerName,
    required this.productId,
    required this.productName,
    required this.lastMessage,
    required this.lastMessageAt,
    required this.unreadCount,
    required this.isDraft,
  });

  const ConversationEntity.empty()
    : id = 0,
      sellerId = '',
      sellerName = '',
      sellerAvatar = '',
      buyerId = '',
      buyerName = '',
      productId = null,
      productName = '',
      lastMessage = '',
      lastMessageAt = null,
      unreadCount = 0,
      isDraft = true;

  ConversationEntity copyWith({
    int? id,
    String? sellerId,
    String? sellerName,
    String? sellerAvatar,
    String? buyerId,
    String? buyerName,
    int? productId,
    String? productName,
    String? lastMessage,
    DateTime? lastMessageAt,
    int? unreadCount,
    bool? isDraft,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerAvatar: sellerAvatar ?? this.sellerAvatar,
      buyerId: buyerId ?? this.buyerId,
      buyerName: buyerName ?? this.buyerName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      unreadCount: unreadCount ?? this.unreadCount,
      isDraft: isDraft ?? this.isDraft,
    );
  }

  @override
  List<Object?> get props => [
    id,
    sellerId,
    sellerName,
    sellerAvatar,
    buyerId,
    buyerName,
    productId,
    productName,
    lastMessage,
    lastMessageAt,
    unreadCount,
    isDraft,
  ];
}
