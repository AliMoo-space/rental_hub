String communityTimeLabel(DateTime? dateTime) {
  if (dateTime == null) return '';

  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inMinutes < 1) return 'الآن';
  if (difference.inHours < 1) return 'منذ ${difference.inMinutes} دقيقة';
  if (difference.inHours < 24) return 'منذ ${difference.inHours} ساعة';
  if (difference.inDays < 7) return 'منذ ${difference.inDays} يوم';
  return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
}
