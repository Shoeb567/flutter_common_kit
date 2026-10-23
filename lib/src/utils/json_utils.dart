/// Utilities for safe, crash-free JSON parsing and casting.
class JsonUtils {
  JsonUtils._();

  /// Safely extracts a string or returns [defaultValue].
  static String safeString(dynamic value, [String defaultValue = '']) {
    if (value == null) return defaultValue;
    if (value is String) return value;
    return value.toString();
  }

  /// Safely extracts an integer or returns [defaultValue].
  static int safeInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) {
      return int.tryParse(value) ??
          double.tryParse(value)?.toInt() ??
          defaultValue;
    }
    return defaultValue;
  }

  /// Safely extracts a double or returns [defaultValue].
  static double safeDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) {
      return double.tryParse(value) ?? defaultValue;
    }
    return defaultValue;
  }

  /// Safely extracts a boolean or returns [defaultValue].
  static bool safeBool(dynamic value, [bool defaultValue = false]) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final lower = value.toLowerCase().trim();
      if (lower == 'true' || lower == '1' || lower == 'yes') return true;
      if (lower == 'false' || lower == '0' || lower == 'no') return false;
    }
    return defaultValue;
  }

  /// Safely extracts a list of type [T].
  static List<T> safeList<T>(
    dynamic value, {
    T Function(dynamic item)? itemMapper,
  }) {
    if (value == null || value is! List) return <T>[];
    if (itemMapper != null) {
      return value.map((item) => itemMapper(item)).toList();
    }
    return value.whereType<T>().toList();
  }

  /// Safely extracts a Map<String, dynamic>.
  static Map<String, dynamic> safeMap(dynamic value) {
    if (value == null || value is! Map) return <String, dynamic>{};
    return Map<String, dynamic>.from(value);
  }

  /// Safely extracts a DateTime.
  static DateTime? safeDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) {
      // Milliseconds or seconds timestamp
      if (value > 1000000000000) {
        return DateTime.fromMillisecondsSinceEpoch(value);
      } else {
        return DateTime.fromMillisecondsSinceEpoch(value * 1000);
      }
    }
    return null;
  }
}
