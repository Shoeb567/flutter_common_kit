/// Categorized error types across network, validation, and storage.
enum ErrorType {
  noInternet,
  connectionTimeout,
  sendTimeout,
  receiveTimeout,
  unauthorized,
  forbidden,
  notFound,
  badRequest,
  serverError,
  invalidResponseFormat,
  emptyResponse,
  fileError,
  storageError,
  validationError,
  unknown,
}

/// Standardized error model with detailed diagnostics and user-friendly messages.
class AppError implements Exception {
  /// User-friendly, localized or display-ready message.
  final String message;

  /// HTTP status code or platform error code, if available.
  final int? statusCode;

  /// Semantic error category.
  final ErrorType type;

  /// Original raw exception or underlying cause.
  final dynamic originalException;

  /// Stack trace for debugging.
  final StackTrace? stackTrace;

  const AppError({
    required this.message,
    this.statusCode,
    this.type = ErrorType.unknown,
    this.originalException,
    this.stackTrace,
  });

  @override
  String toString() {
    return 'AppError(type: $type, statusCode: $statusCode, message: $message)';
  }
}
