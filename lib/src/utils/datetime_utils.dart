import 'package:intl/intl.dart';

/// Utilities for standard date and time formatting and parsing.
class DateTimeUtils {
  DateTimeUtils._();

  static const String formatYyyyMmDd = 'yyyy-MM-dd';
  static const String formatDdMmYyyy = 'dd/MM/yyyy';
  static const String formatDMyyyy = 'd MMM yyyy';
  static const String formatDMonthYyyy = 'd MMMM yyyy';
  static const String formatHhMm = 'hh:mm a';
  static const String formatHhMm24 = 'HH:mm';
  static const String formatDateTime = 'dd/MM/yyyy hh:mm a';
  static const String formatIso8601 = "yyyy-MM-dd'T'HH:mm:ss'Z'";

  /// Formats a [DateTime] into a string using the provided [format].
  static String format(
    DateTime? date, {
    String format = formatDdMmYyyy,
    String? locale,
  }) {
    if (date == null) return '';
    return DateFormat(format, locale).format(date);
  }

  /// Parses a date string into a [DateTime] safely, returning `null` if invalid.
  static DateTime? tryParse(String? dateStr, {String? format}) {
    if (dateStr == null || dateStr.trim().isEmpty) return null;
    try {
      if (format != null) {
        return DateFormat(format).parse(dateStr);
      }
      return DateTime.tryParse(dateStr);
    } catch (_) {
      return null;
    }
  }

  /// Returns a human-friendly "time ago" string (e.g., "5m ago", "2h ago", "Yesterday").
  static String timeAgo(DateTime? date) {
    if (date == null) return '';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      final mins = difference.inMinutes;
      return '$mins ${mins == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours ${hours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return '$days ${days == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  /// Checks if two [DateTime] instances occur on the same calendar day.
  static bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Checks if a [DateTime] is today.
  static bool isToday(DateTime? date) {
    return isSameDay(date, DateTime.now());
  }
}
