import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }
  Future<String?> getUserRole() async {
    return await _storage.read(key: 'UserRole');
  }
  Future<String?> getUserGuid() async {
    return await _storage.read(key: 'UserGuid');
  }

  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refreshToken', value: token);
  }
  Future<void> saveUserRole(String token) async {
    await _storage.write(key: 'UserRole', value: token);
  }
  Future<void> saveUserGuid(String token) async {
    await _storage.write(key: 'UserGuid', value: token);
  }
}
