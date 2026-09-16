import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();
  static SecureStorage get instance => SecureStorage._();

  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<void> setToken(String v) async {
    return _storage.write(key: "token", value: v);
  }

  Future<String?> getToken() async {
    String? token = await _storage.read(key: "token");
    return token;
  }

  Future<void> setUID(String v) async {
    return _storage.write(key: "key", value: v);
  }

  Future<String?> getUID() async {
    String? token = await _storage.read(key: "key");
    return token;
  }

  Future<void> reset() async {
    return _storage.deleteAll();
  }
}
