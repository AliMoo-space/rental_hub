class ProductReviewEntity {
  final int id;
  final String userId;
  final String userName;
  final String? userImage;
  final int score;
  final String? comment;
  final DateTime createdAt;

  const ProductReviewEntity({
    required this.id,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.score,
    required this.comment,
    required this.createdAt,
  });

  bool get hasComment => (comment ?? '').trim().isNotEmpty;
}
