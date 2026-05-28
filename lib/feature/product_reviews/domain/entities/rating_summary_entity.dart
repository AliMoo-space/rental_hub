class RatingSummaryEntity {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> distribution;

  const RatingSummaryEntity({
    required this.averageRating,
    required this.totalReviews,
    required this.distribution,
  });

  int countFor(int star) => distribution[star] ?? 0;

  static const empty = RatingSummaryEntity(
    averageRating: 0,
    totalReviews: 0,
    distribution: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0},
  );
}
