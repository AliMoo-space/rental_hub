import 'dart:convert';

import 'package:rental_hub/core/databases/cache/cache_helper.dart';

class CategoryLocalDataSource {
  final CacheHelper cacheHelper;

  CategoryLocalDataSource({required this.cacheHelper});

  Future<void> cacheCategories(Map<String, dynamic> categories) async {
    final jsonString = jsonEncode(categories);

    await cacheHelper.saveData(key: 'categories', value: jsonString);
  }

  Future<Map<String, dynamic>?> getCachedCategories() async {
    final data = cacheHelper.getString(key: 'categories');

    if (data == null) return null;

    try {
      final decoded = jsonDecode(data);

      return Map<String, dynamic>.from(decoded);
    } catch (e) {
      return null;
    }
  }
}
