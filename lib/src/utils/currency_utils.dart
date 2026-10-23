import 'package:intl/intl.dart';

/// Utilities for formatting currencies and numbers.
class CurrencyUtils {
  CurrencyUtils._();

  /// Formats a numeric value with currency symbol and decimal formatting.
  /// Example: format(1250.5, symbol: '₹') -> '₹1,250.50'
  static String format(
    num? amount, {
    String symbol = '\$',
    int decimalDigits = 2,
    String? locale,
  }) {
    if (amount == null) return '$symbol${0.toStringAsFixed(decimalDigits)}';
    final formatter = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      locale: locale,
    );
    return formatter.format(amount);
  }

  /// Formats large numbers compactly.
  /// Example: formatCompact(1500) -> '1.5K', formatCompact(2000000) -> '2M'
  static String formatCompact(num? amount, {String? locale}) {
    if (amount == null) return '0';
    return NumberFormat.compact(locale: locale).format(amount);
  }

  /// Formats a number with comma separators.
  /// Example: 1000000 -> '1,000,000'
  static String formatNumber(num? value, {int? decimalDigits, String? locale}) {
    if (value == null) return '0';
    final formatter = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits,
    );
    return formatter.format(value);
  }
}
