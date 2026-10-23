import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// Centralized wrapper around [SharedPreferences] for non-sensitive local storage.
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Initializes an instance with underlying [SharedPreferences].
  static Future<StorageService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return StorageService(prefs);
  }

  // ==================== STRING ==================== //

  /// Saves a string value.
  Future<bool> setString(String key, String value) => _prefs.setString(key, value);

  /// Retrieves a string value or returns [defaultValue].
  String? getString(String key, [String? defaultValue]) =>
      _prefs.getString(key) ?? defaultValue;

  // ==================== INTEGER ==================== //

  /// Saves an integer value.
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  /// Retrieves an integer value or returns [defaultValue].
  int? getInt(String key, [int? defaultValue]) =>
      _prefs.getInt(key) ?? defaultValue;

  // ==================== DOUBLE ==================== //

  /// Saves a double value.
  Future<bool> setDouble(String key, double value) => _prefs.setDouble(key, value);

  /// Retrieves a double value or returns [defaultValue].
  double? getDouble(String key, [double? defaultValue]) =>
      _prefs.getDouble(key) ?? defaultValue;

  // ==================== BOOLEAN ==================== //

  /// Saves a boolean value.
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  /// Retrieves a boolean value or returns [defaultValue].
  bool? getBool(String key, [bool? defaultValue]) =>
      _prefs.getBool(key) ?? defaultValue;

  // ==================== STRING LIST ==================== //

  /// Saves a list of strings.
  Future<bool> setStringList(String key, List<String> value) =>
      _prefs.setStringList(key, value);

  /// Retrieves a list of strings or returns [defaultValue].
  List<String>? getStringList(String key, [List<String>? defaultValue]) =>
      _prefs.getStringList(key) ?? defaultValue;

  // ==================== JSON OBJECT ==================== //

  /// Encodes and saves a JSON-compatible map or list.
  Future<bool> setJson(String key, dynamic jsonValue) {
    final encoded = jsonEncode(jsonValue);
    return _prefs.setString(key, encoded);
  }

  /// Retrieves and decodes a saved JSON object map.
  Map<String, dynamic>? getJson(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  /// Retrieves and decodes a saved JSON list.
  List<dynamic>? getJsonList(String key) {
    final raw = _prefs.getString(key);
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded;
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // ==================== MANAGEMENT ==================== //

  /// Checks if a key exists in storage.
  bool containsKey(String key) => _prefs.containsKey(key);

  /// Removes a single key.
  Future<bool> remove(String key) => _prefs.remove(key);

  /// Clears all preferences stored by this application.
  Future<bool> clear() => _prefs.clear();

  /// Gets all stored keys.
  Set<String> getKeys() => _prefs.getKeys();
}
