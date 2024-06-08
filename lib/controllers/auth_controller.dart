import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthController {
  static const String _tokenKey = 'auth_token';
  static const String _name ='';
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
    return await _storage.read(key: _name);
  }

  static Future<void> setName(String name) async {
    await _storage.write(key: _name, value: name);
  }

  static Future<void> removeName() async {
    await _storage.delete(key: _name);
  }
}