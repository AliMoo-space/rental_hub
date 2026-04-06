import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? _preferences;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  SharedPreferences get _prefs {
    final instance = _preferences;
    if (instance == null) {
      throw StateError(
        'CacheHelper is not initialized. Call CacheHelper.init() first.',
      );
    }
    return instance;
  }

  Future<bool> saveData({required String key, required dynamic value}) {
    if (value is String) {
      return _prefs.setString(key, value);
    }
    if (value is int) {
      return _prefs.setInt(key, value);
    }
    if (value is double) {
      return _prefs.setDouble(key, value);
    }
    if (value is bool) {
      return _prefs.setBool(key, value);
    }
    if (value is List<String>) {
      return _prefs.setStringList(key, value);
    }

    throw ArgumentError(
      'Unsupported value type: ${value.runtimeType}. '
      'Only String, int, double, bool, and List<String> are supported.',
    );
  }

  dynamic getData({required String key}) => _prefs.get(key);

  String? getString({required String key}) => _prefs.getString(key);

  int? getInt({required String key}) => _prefs.getInt(key);

  double? getDouble({required String key}) => _prefs.getDouble(key);

  bool? getBool({required String key}) => _prefs.getBool(key);

  List<String>? getStringList({required String key}) {
    return _prefs.getStringList(key);
  }

  Future<bool> removeData({required String key}) => _prefs.remove(key);

  Future<bool> clearData() => _prefs.clear();

  bool containsKey({required String key}) => _prefs.containsKey(key);

  Future<void> saveSecureData({required String key, required String value}) {
    return _secureStorage.write(key: key, value: value);
  }

  Future<String?> getSecureData({required String key}) {
    return _secureStorage.read(key: key);
  }

  Future<void> removeSecureData({required String key}) {
    return _secureStorage.delete(key: key);
  }

  Future<void> clearSecureData() {
    return _secureStorage.deleteAll();
  }
}
