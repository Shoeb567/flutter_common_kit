# Changelog

## 0.0.1

Initial release of `flutter_common_kit` — a production-ready toolkit for Flutter applications.

### Features
* **Package Initialization**: Easy `FlutterCommonKit.initialize()` hub for configuring base URL, logging, colors, and timeouts.
* **Centralized API Service**: Complete HTTP client powered by `Dio` supporting `GET`, `POST`, `PUT`, `PATCH`, `DELETE`, multipart file upload, multi-file upload, file download with progress, cancel tokens, bearer token injection, and structured `ApiResponse` and `ApiResult`.
* **Centralized Storage**:
  * `StorageService`: SharedPreferences wrapper for strings, ints, doubles, booleans, string lists, and JSON models.
  * `SecureStorageService`: Encrypted storage via platform Keystore/Keychain for tokens and secrets.
  * `AuthStorageHelper`: Unified credential and session coordination.
* **Internet Connectivity**:
  * Real-time network reachability detection with active DNS check.
  * `ConnectivityListenerWidget` and offline banner / fallback widgets.
* **Common UI Components**:
  * `CommonAppBar`: Customizable title, navigation, actions, and theming.
  * `CommonButton`, `CommonOutlinedButton`, `CommonTextButton`: Loading states, icons, and adaptive styling.
  * `CommonTextField`, `CommonPasswordField`: Input validation, clear button, and visibility toggle.
  * `CommonLoader` and `CommonShimmer`: Adaptive spinner and skeleton loading cards and list tiles.
  * `CommonDialogs`, `CommonBottomSheet`, `CommonSnackbar`, `CommonToast`: Modern alert dialogs, modal sheets, and floating notifications.
  * `CommonCard`, `CommonContainer`, `CommonDivider`: Consistent container styling and separators.
  * `ResponsiveHelper` & `ResponsiveLayout`: Mobile, tablet, and desktop layout helpers.
* **Error Handling**: Standardized `AppError`, categorized `ErrorType`, and `ErrorHandler` converting Dio, socket, and format exceptions into user-friendly messages.
* **Utilities & Validators**:
  * `Validators`: Email, phone, password strength, min/max length, required, URL, and compose.
  * `JsonUtils`: Crash-free safe parsing for JSON values.
  * `DateTimeUtils`: Formatting, parsing, and relative "time ago" helpers.
  * `CurrencyUtils`: Compact and currency formatting.
  * `Debouncer` & `Throttler`: Input debouncing and rate limiting.
  * `ContextExtensions`, `StringExtensions`, `NumExtensions`: Ergonomic Flutter extensions.
* **Theming**: Ready-to-use Material 3 `CommonTheme.lightTheme` and `CommonTheme.darkTheme`.
