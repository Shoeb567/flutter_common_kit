/// Reusable form input validator functions returning error message or `null`.
class Validators {
  Validators._();

  static final RegExp _emailRegExp = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp _phoneRegExp = RegExp(
    r'^\+?[0-9]{7,15}$',
  );

  static final RegExp _urlRegExp = RegExp(
    r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
  );

  /// Validates that a string is not null or whitespace.
  static String? required(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return message ?? 'This field is required.';
    }
    return null;
  }

  /// Validates standard email address format.
  static String? email(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return null; // Empty check should be handled by required if needed
    }
    if (!_emailRegExp.hasMatch(value.trim())) {
      return message ?? 'Please enter a valid email address.';
    }
    return null;
  }

  /// Validates standard international or local phone numbers.
  static String? phone(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!_phoneRegExp.hasMatch(cleaned)) {
      return message ?? 'Please enter a valid phone number.';
    }
    return null;
  }

  /// Validates minimum string length.
  static String? minLength(String? value, int min, [String? message]) {
    if (value == null || value.length < min) {
      return message ?? 'Must be at least $min characters long.';
    }
    return null;
  }

  /// Validates maximum string length.
  static String? maxLength(String? value, int max, [String? message]) {
    if (value != null && value.length > max) {
      return message ?? 'Must not exceed $max characters.';
    }
    return null;
  }

  /// Validates password strength (length, uppercase, numbers, special characters).
  static String? password(
    String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireDigit = true,
    bool requireSpecialChar = false,
    String? message,
  }) {
    if (value == null || value.length < minLength) {
      return message ?? 'Password must be at least $minLength characters.';
    }
    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return message ?? 'Password must contain at least one uppercase letter.';
    }
    if (requireDigit && !value.contains(RegExp(r'[0-9]'))) {
      return message ?? 'Password must contain at least one number.';
    }
    if (requireSpecialChar && !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return message ?? 'Password must contain at least one special character.';
    }
    return null;
  }

  /// Validates that two passwords match.
  static String? confirmPassword(
    String? value,
    String? originalPassword, [
    String? message,
  ]) {
    if (value == null || value.isEmpty) {
      return message ?? 'Please confirm your password.';
    }
    if (value != originalPassword) {
      return message ?? 'Passwords do not match.';
    }
    return null;
  }

  /// Validates web URL format.
  static String? url(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (!_urlRegExp.hasMatch(value.trim())) {
      return message ?? 'Please enter a valid URL.';
    }
    return null;
  }

  /// Validates numeric input.
  static String? numeric(String? value, [String? message]) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (num.tryParse(value.trim()) == null) {
      return message ?? 'Please enter a valid numeric value.';
    }
    return null;
  }

  /// Chains multiple validators sequentially. Stops at the first failing validator.
  static String? Function(String?) compose(
    List<String? Function(String?)> validators,
  ) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}
