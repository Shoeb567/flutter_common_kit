/// Standard wrapper model for API responses.
class ApiResponse<T> {
  /// Whether the request completed successfully (status 2xx).
  final bool isSuccess;

  /// Parsed response data payload.
  final T? data;

  /// User-friendly or server-provided status message.
  final String? message;

  /// HTTP status code.
  final int? statusCode;

  /// List or map of validation errors, if any.
  final dynamic errors;

  /// Raw response body map or dynamic data.
  final dynamic rawData;

  const ApiResponse({
    required this.isSuccess,
    this.data,
    this.message,
    this.statusCode,
    this.errors,
    this.rawData,
  });

  /// Factory constructor for successful response.
  factory ApiResponse.success({
    T? data,
    String? message,
    int? statusCode,
    dynamic rawData,
  }) {
    return ApiResponse<T>(
      isSuccess: true,
      data: data,
      message: message,
      statusCode: statusCode ?? 200,
      rawData: rawData,
    );
  }

  /// Factory constructor for failure response.
  factory ApiResponse.failure({
    String? message,
    int? statusCode,
    dynamic errors,
    dynamic rawData,
  }) {
    return ApiResponse<T>(
      isSuccess: false,
      message: message,
      statusCode: statusCode,
      errors: errors,
      rawData: rawData,
    );
  }

  /// Transforms the data using [transform] if present.
  ApiResponse<R> map<R>(R Function(T? data) transform) {
    return ApiResponse<R>(
      isSuccess: isSuccess,
      data: transform(data),
      message: message,
      statusCode: statusCode,
      errors: errors,
      rawData: rawData,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(isSuccess: $isSuccess, statusCode: $statusCode, message: $message, data: $data)';
  }
}
