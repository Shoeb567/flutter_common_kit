import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Dedicated service for encrypted and sensitive local storage
/// using platform-native keystore (Android Keystore / iOS Keychain).
class SecureStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
              iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
            );

  /// Saves an encrypted string value.
  Future<void> write(String key, String value) =>
      _secureStorage.write(key: key, value: value);

  /// Reads an encrypted string value.
  Future<String?> read(String key) => _secureStorage.read(key: key);

  /// Checks if a secure key exists.
  Future<bool> containsKey(String key) => _secureStorage.containsKey(key: key);

  /// Deletes a single secure key.
  Future<void> delete(String key) => _secureStorage.delete(key: key);

  /// Deletes all encrypted keys.
  Future<void> deleteAll() => _secureStorage.deleteAll();

  /// Reads all encrypted key-value pairs.
  Future<Map<String, String>> readAll() => _secureStorage.readAll();
}
