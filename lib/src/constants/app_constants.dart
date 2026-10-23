/// Default string constants, network timeout values, and storage keys.
class AppConstants {
  AppConstants._();

  // Network Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  // Storage Keys
  static const String keyAccessToken = 'common_kit_access_token';
  static const String keyRefreshToken = 'common_kit_refresh_token';
  static const String keyUserData = 'common_kit_user_data';
  static const String keyIsLoggedIn = 'common_kit_is_logged_in';
  static const String keyThemeMode = 'common_kit_theme_mode';
  static const String keyLocale = 'common_kit_locale';

  // Default Error Messages
  static const String defaultNoInternetMsg =
      'No internet connection available. Please check your network settings.';
  static const String defaultConnectionTimeoutMsg =
      'Connection timed out. Please try again later.';
  static const String defaultReceiveTimeoutMsg =
      'Server took too long to respond. Please try again.';
  static const String defaultSendTimeoutMsg =
      'Request sending timed out. Please try again.';
  static const String defaultUnauthorizedMsg =
      'Session expired or unauthorized. Please sign in again.';
  static const String defaultForbiddenMsg =
      'You do not have permission to access this resource.';
  static const String defaultNotFoundMsg =
      'The requested resource was not found on the server.';
  static const String defaultServerErrMsg =
      'Internal server error occurred. Please try again later.';
  static const String defaultBadRequestMsg =
      'Invalid request. Please verify your inputs.';
  static const String defaultUnknownErrMsg =
      'An unexpected error occurred. Please try again.';
  static const String defaultCancelErrMsg =
      'The network request was cancelled.';
}
