enum ChatMessageStatus { sent, delivered, read }

extension ChatMessageStatusX on ChatMessageStatus {
  String get apiValue {
    switch (this) {
      case ChatMessageStatus.sent:
        return 'sent';
      case ChatMessageStatus.delivered:
        return 'delivered';
      case ChatMessageStatus.read:
        return 'read';
    }
  }

  static ChatMessageStatus fromValue(dynamic value) {
    final normalized = value?.toString().trim().toLowerCase() ?? '';

    switch (normalized) {
      case 'delivered':
        return ChatMessageStatus.delivered;
      case 'read':
        return ChatMessageStatus.read;
      case 'sent':
      default:
        return ChatMessageStatus.sent;
    }
  }
}
