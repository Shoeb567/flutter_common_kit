import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Callback type for token retrieval.
typedef TokenProvider = Future<String?> Function();

/// Callback type for token refresh handling.
typedef RefreshTokenCallback = Future<String?> Function(String? currentRefreshToken);

/// Central configuration class for `FlutterCommonKit`.
///
/// Allows configuring base URL, timeouts, colors, logging, and token providers
/// without hardcoding values inside the package.
class CommonKitConfig {
  /// Base API URL for network requests.
  final String? baseUrl;

  /// Application display name.
  final String appName;

  /// Primary theme color.
  final Color primaryColor;

  /// Secondary/accent theme color.
  final Color secondaryColor;

  /// Scaffold background color for light mode.
  final Color lightScaffoldColor;

  /// Scaffold background color for dark mode.
  final Color darkScaffoldColor;

  /// Default API connection timeout.
  final Duration connectTimeout;

  /// Default API receive timeout.
  final Duration receiveTimeout;

  /// Default API send timeout.
  final Duration sendTimeout;

  /// Default headers to include in every network request.
  final Map<String, dynamic> defaultHeaders;

  /// Whether to enable network & debug logging.
  final bool enableLogging;

  /// Provider for the authorization token (e.g. Bearer token).
  final TokenProvider? tokenProvider;

  /// Callback when a 401 Unauthorized response is received.
  final VoidCallback? onUnauthorized;

  /// Callback to refresh authentication token when expired.
  final RefreshTokenCallback? onRefreshToken;

  /// Optional custom error messages map overriding default status code messages.
  final Map<int, String> customErrorMessages;

  const CommonKitConfig({
    this.baseUrl,
    this.appName = 'Flutter App',
    this.primaryColor = const Color(0xFF2563EB), // Modern Royal Blue
    this.secondaryColor = const Color(0xFF10B981), // Emerald Green
    this.lightScaffoldColor = const Color(0xFFF8FAFC),
    this.darkScaffoldColor = const Color(0xFF0F172A),
    this.connectTimeout = AppConstants.connectTimeout,
    this.receiveTimeout = AppConstants.receiveTimeout,
    this.sendTimeout = AppConstants.sendTimeout,
    this.defaultHeaders = const {},
    this.enableLogging = true,
    this.tokenProvider,
    this.onUnauthorized,
    this.onRefreshToken,
    this.customErrorMessages = const {},
  });

  /// Creates a copy with modified values.
  CommonKitConfig copyWith({
    String? baseUrl,
    String? appName,
    Color? primaryColor,
    Color? secondaryColor,
    Color? lightScaffoldColor,
    Color? darkScaffoldColor,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
    Map<String, dynamic>? defaultHeaders,
    bool? enableLogging,
    TokenProvider? tokenProvider,
    VoidCallback? onUnauthorized,
    RefreshTokenCallback? onRefreshToken,
    Map<int, String>? customErrorMessages,
  }) {
    return CommonKitConfig(
      baseUrl: baseUrl ?? this.baseUrl,
      appName: appName ?? this.appName,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      lightScaffoldColor: lightScaffoldColor ?? this.lightScaffoldColor,
      darkScaffoldColor: darkScaffoldColor ?? this.darkScaffoldColor,
      connectTimeout: connectTimeout ?? this.connectTimeout,
      receiveTimeout: receiveTimeout ?? this.receiveTimeout,
      sendTimeout: sendTimeout ?? this.sendTimeout,
      defaultHeaders: defaultHeaders ?? this.defaultHeaders,
      enableLogging: enableLogging ?? this.enableLogging,
      tokenProvider: tokenProvider ?? this.tokenProvider,
      onUnauthorized: onUnauthorized ?? this.onUnauthorized,
      onRefreshToken: onRefreshToken ?? this.onRefreshToken,
      customErrorMessages: customErrorMessages ?? this.customErrorMessages,
    );
  }
}
