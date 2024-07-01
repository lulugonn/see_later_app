import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  static const String _tokenKey = 'auth_token';
  static const String _nameKey = 'user_name';
  static const String _filtersKey = 'last_filters';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> setToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<String?> getName() async {
    return await _storage.read(key: _nameKey);
  }

  static Future<void> setName(String name) async {
    await _storage.write(key: _nameKey, value: name);
  }

  static Future<void> removeName() async {
    await _storage.delete(key: _nameKey);
  }

static Future<List<String>> getLastFilters() async {
    String? jsonString = await _storage.read(key: _filtersKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      return jsonString.split(',');
    }
    return [];
  }

  static Future<void> setLastFilters(List<String> filters) async {
    String jsonString = filters.join(',');
    await _storage.write(key: _filtersKey, value: jsonString);
  }
  static Future<void> removeLastFilters() async {
    await _storage.delete(key: _filtersKey);
  }
}