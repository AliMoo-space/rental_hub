class ChatRouteArgs {
  final int? conversationId;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final int? productId;
  final String productName;

  const ChatRouteArgs({
    this.conversationId,
    this.sellerId = '',
    this.sellerName = '',
    this.sellerAvatar = '',
    this.productId,
    this.productName = '',
  });

  bool get hasConversationId => conversationId != null && conversationId! > 0;

  bool get hasSeller => sellerId.trim().isNotEmpty;
}

class ChatRouteArgs {
  final int? conversationId;
  final String sellerId;
  final String sellerName;
  final String sellerAvatar;
  final int? productId;
  final String productName;

  const ChatRouteArgs({
    this.conversationId,
    this.sellerId = '',
    this.sellerName = '',
    this.sellerAvatar = '',
    this.productId,
    this.productName = '',
  });

  bool get hasConversationId => conversationId != null && conversationId! > 0;

  bool get hasSeller => sellerId.trim().isNotEmpty;
}
