import 'package:flutter/foundation.dart';

class FavoriteStateManager {
  final Set<int> _favoriteIds = {};
  final ValueNotifier<Set<int>> notifier = ValueNotifier({});

  Set<int> get favoriteIds => Set.unmodifiable(_favoriteIds);

  bool contains(int productId) => _favoriteIds.contains(productId);

  void add(int productId) {
    _favoriteIds.add(productId);
    notifier.value = Set.from(_favoriteIds);
  }

  void remove(int productId) {
    _favoriteIds.remove(productId);
    notifier.value = Set.from(_favoriteIds);
  }

  void addAll(Iterable<int> ids) {
    _favoriteIds.addAll(ids);
    notifier.value = Set.from(_favoriteIds);
  }

  void clear() {
    _favoriteIds.clear();
    notifier.value = {};
  }

  void toggle(int productId) {
    if (_favoriteIds.contains(productId)) {
      _favoriteIds.remove(productId);
    } else {
      _favoriteIds.add(productId);
    }
    notifier.value = Set.from(_favoriteIds);
  }
}
