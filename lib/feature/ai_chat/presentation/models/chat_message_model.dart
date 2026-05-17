import 'package:rental_hub/feature/ai_chat/presentation/models/product_preview.dart';

class ChatMessageModel {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final List<String> imageUrls;
  final List<ProductPreview> products;

  const ChatMessageModel({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.imageUrls = const [],
    this.products = const [],
  });
}
