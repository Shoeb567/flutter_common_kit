import 'dart:io';
import 'package:dio/dio.dart';
import 'app_error.dart';
import '../network/network_exceptions.dart';
import '../constants/app_constants.dart';

/// Centralized utility to normalize any caught error into a typed [AppError].
class ErrorHandler {
  ErrorHandler._();

  /// Maps any dynamic error or exception into a structured [AppError].
  static AppError handleError(dynamic error, [StackTrace? stackTrace]) {
    if (error is AppError) {
      return error;
    }

    if (error is DioException) {
      return NetworkException.fromDioException(error);
    }

    if (error is SocketException) {
      return AppError(
        message: AppConstants.defaultNoInternetMsg,
        type: ErrorType.noInternet,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    if (error is FormatException) {
      return AppError(
        message: 'Invalid data format or unable to parse response.',
        type: ErrorType.invalidResponseFormat,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    if (error is TypeError) {
      return AppError(
        message: 'Data parsing failed due to a type mismatch.',
        type: ErrorType.invalidResponseFormat,
        originalException: error,
        stackTrace: stackTrace,
      );
    }

    return AppError(
      message: error?.toString() ?? AppConstants.defaultUnknownErrMsg,
      type: ErrorType.unknown,
      originalException: error,
      stackTrace: stackTrace,
    );
  }
}
