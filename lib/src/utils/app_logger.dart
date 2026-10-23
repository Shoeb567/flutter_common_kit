import 'package:flutter/foundation.dart';

/// Centralized logger that ensures logs only appear in debug mode or when explicitly permitted.
class AppLogger {
  AppLogger._();

  static bool isEnabled = true;

  /// Logs informational message.
  static void info(dynamic message, [String tag = 'INFO']) {
    _log(tag, message);
  }

  /// Logs debug message.
  static void debug(dynamic message, [String tag = 'DEBUG']) {
    _log(tag, message);
  }

  /// Logs warning message.
  static void warning(dynamic message, [String tag = 'WARN']) {
    _log(tag, message);
  }

  /// Logs error message with optional stack trace.
  static void error(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
    String tag = 'ERROR',
  ]) {
    if (!isEnabled || !kDebugMode) return;
    final buffer = StringBuffer();
    buffer.writeln('[$tag] $message');
    if (error != null) buffer.writeln('Details: $error');
    if (stackTrace != null) buffer.writeln('StackTrace:\n$stackTrace');
    debugPrint(buffer.toString());
  }

  static void _log(String tag, dynamic message) {
    if (isEnabled && kDebugMode) {
      debugPrint('[$tag] $message');
    }
  }
}
