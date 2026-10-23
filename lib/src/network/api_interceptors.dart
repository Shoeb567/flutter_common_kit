import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/common_kit_config.dart';

/// Interceptor that attaches authorization tokens and global headers to outgoing requests.
class AuthInterceptor extends QueuedInterceptor {
  final CommonKitConfig config;

  AuthInterceptor({required this.config});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add default headers
    if (config.defaultHeaders.isNotEmpty) {
      options.headers.addAll(config.defaultHeaders);
    }

    // Attach Bearer token if not already explicitly provided
    if (!options.headers.containsKey('Authorization') && config.tokenProvider != null) {
      try {
        final token = await config.tokenProvider!();
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (e) {
        if (kDebugMode && config.enableLogging) {
          debugPrint('[FlutterCommonKit] Error retrieving auth token: $e');
        }
      }
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Check if token expired (401 Unauthorized)
    if (err.response?.statusCode == 401) {
      if (config.onUnauthorized != null) {
        config.onUnauthorized!();
      }
    }
    return handler.next(err);
  }
}

/// Custom logging interceptor that formats requests, responses, and errors cleanly.
class AppLoggingInterceptor extends Interceptor {
  final bool enableLogging;

  AppLoggingInterceptor({this.enableLogging = true});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode && enableLogging) {
      final buffer = StringBuffer();
      buffer.writeln('--> ${options.method} ${options.uri}');
      if (options.headers.isNotEmpty) {
        buffer.writeln('Headers: ${options.headers}');
      }
      if (options.queryParameters.isNotEmpty) {
        buffer.writeln('Query: ${options.queryParameters}');
      }
      if (options.data != null) {
        buffer.writeln('Body: ${options.data}');
      }
      debugPrint(buffer.toString().trim());
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode && enableLogging) {
      final buffer = StringBuffer();
      buffer.writeln('<-- ${response.statusCode} ${response.requestOptions.uri}');
      buffer.writeln('Data: ${response.data}');
      debugPrint(buffer.toString().trim());
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode && enableLogging) {
      final buffer = StringBuffer();
      buffer.writeln('<-- ERROR ${err.response?.statusCode ?? 'NO_STATUS'} ${err.requestOptions.uri}');
      buffer.writeln('Message: ${err.message}');
      if (err.response?.data != null) {
        buffer.writeln('Response Data: ${err.response?.data}');
      }
      debugPrint(buffer.toString().trim());
    }
    return super.onError(err, handler);
  }
}
