/// Helpful extensions on String types.
extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Capitalizes each word in the string.
  String capitalizeWords() {
    if (isEmpty) return this;
    return split(' ').map((word) {
      if (word.isEmpty) return word;
      return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
    }).join(' ');
  }

  /// Safely converts string to integer or returns `null`.
  int? toIntOrNull() => int.tryParse(this);

  /// Safely converts string to double or returns `null`.
  double? toDoubleOrNull() => double.tryParse(this);

  /// Removes all whitespace characters.
  String removeWhitespace() => replaceAll(RegExp(r'\s+'), '');
}

/// Helpful extensions on nullable String types.
extension NullableStringExtensions on String? {
  /// Returns `true` if string is null or contains only whitespace.
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// Returns `true` if string is not null and not empty.
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
