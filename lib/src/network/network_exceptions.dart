import 'dart:io';
import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../error_handling/app_error.dart';

/// Exception thrown on network or API failures.
class NetworkException extends AppError {
  const NetworkException({
    required super.message,
    super.statusCode,
    super.type,
    super.originalException,
    super.stackTrace,
  });

  /// Factory constructor to convert any DioException into an AppError / NetworkException.
  factory NetworkException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return NetworkException(
          message: AppConstants.defaultConnectionTimeoutMsg,
          type: ErrorType.connectionTimeout,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.sendTimeout:
        return NetworkException(
          message: AppConstants.defaultSendTimeoutMsg,
          type: ErrorType.sendTimeout,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return NetworkException(
          message: AppConstants.defaultReceiveTimeoutMsg,
          type: ErrorType.receiveTimeout,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Security certificate verification failed.',
          type: ErrorType.serverError,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException);
      case DioExceptionType.cancel:
        return NetworkException(
          message: AppConstants.defaultCancelErrMsg,
          type: ErrorType.unknown,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.connectionError:
        return NetworkException(
          message: AppConstants.defaultNoInternetMsg,
          type: ErrorType.noInternet,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
      case DioExceptionType.unknown:
        if (dioException.error is SocketException) {
          return NetworkException(
            message: AppConstants.defaultNoInternetMsg,
            type: ErrorType.noInternet,
            originalException: dioException.error,
            stackTrace: dioException.stackTrace,
          );
        }
        return NetworkException(
          message: dioException.message ?? AppConstants.defaultUnknownErrMsg,
          type: ErrorType.unknown,
          originalException: dioException,
          stackTrace: dioException.stackTrace,
        );
    }
  }

  static NetworkException _handleBadResponse(DioException dioException) {
    final response = dioException.response;
    final statusCode = response?.statusCode;
    String message = AppConstants.defaultUnknownErrMsg;
    ErrorType errorType = ErrorType.unknown;

    // Check if server sent a specific error message in response body
    if (response?.data != null) {
      if (response!.data is Map<String, dynamic>) {
        final data = response.data as Map<String, dynamic>;
        message = data['message']?.toString() ??
            data['error']?.toString() ??
            data['msg']?.toString() ??
            data['detail']?.toString() ??
            '';
      } else if (response.data is String && (response.data as String).isNotEmpty) {
        message = response.data as String;
      }
    }

    if (statusCode != null) {
      switch (statusCode) {
        case 400:
          errorType = ErrorType.badRequest;
          if (message.isEmpty) message = AppConstants.defaultBadRequestMsg;
          break;
        case 401:
          errorType = ErrorType.unauthorized;
          if (message.isEmpty) message = AppConstants.defaultUnauthorizedMsg;
          break;
        case 403:
          errorType = ErrorType.forbidden;
          if (message.isEmpty) message = AppConstants.defaultForbiddenMsg;
          break;
        case 404:
          errorType = ErrorType.notFound;
          if (message.isEmpty) message = AppConstants.defaultNotFoundMsg;
          break;
        case 500:
        case 502:
        case 503:
        case 504:
          errorType = ErrorType.serverError;
          if (message.isEmpty) message = AppConstants.defaultServerErrMsg;
          break;
        default:
          if (message.isEmpty) {
            message = 'Request failed with status code $statusCode';
          }
      }
    }

    return NetworkException(
      message: message.isNotEmpty ? message : AppConstants.defaultUnknownErrMsg,
      statusCode: statusCode,
      type: errorType,
      originalException: dioException,
      stackTrace: dioException.stackTrace,
    );
  }
}
