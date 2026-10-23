# Flutter Common Kit

A modern, production-ready, batteries-included toolkit for Flutter applications. Eliminates boilerplate code by providing centralized API networking, secure & local storage, real-time connectivity detection, reusable UI components, centralized error handling, and robust utilities.

[![Pub Version](https://img.shields.io/badge/pub-v0.0.1-blue)](https://pub.dev/packages/flutter_common_kit)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-3.19+-02569B?logo=flutter)](https://flutter.dev)

---

## 🚀 Features

* **⚡ Zero-Boilerplate Package Initialization**: Configure base URL, logging, colors, and headers once in `main()`.
* **🌐 Centralized API Client (Dio)**:
  * Full HTTP support: `GET`, `POST`, `PUT`, `PATCH`, `DELETE`.
  * Multipart single & multi-file uploads with progress tracking.
  * File downloading with progress callback.
  * Bearer token injection, automatic headers, and token refresh architecture.
  * Request cancellation via `CancelToken`.
  * Unified `ApiResponse<T>` and `ApiResult<T>` sealed class matching (`Success` / `Failure`).
* **💾 Local & Secure Storage**:
  * `StorageService`: Centralized `SharedPreferences` for strings, numbers, booleans, string lists, and JSON objects.
  * `SecureStorageService`: Encrypted keystore/keychain storage for sensitive auth tokens and API secrets.
  * `AuthStorageHelper`: Unified coordinator for access tokens, user profile metadata, and clean logout.
* **📶 Internet Connectivity Detection**:
  * Real-time network interface stream + real DNS reachability verification.
  * `ConnectivityListenerWidget` with offline banner or fallback screen.
* **🎨 Modern UI Components**:
  * `CommonAppBar`: Customizable title, navigation, actions, and theming.
  * `CommonButton`, `CommonOutlinedButton`, `CommonTextButton`: Built-in loading spinner, icons, and flexible sizing.
  * `CommonTextField`, `CommonPasswordField`: Input validation, clear button, and password visibility toggle.
  * `CommonLoader` & `CommonShimmer`: Adaptive spinner and skeleton loading placeholders.
  * `CommonDialogs`, `CommonBottomSheet`, `CommonSnackbar`, `CommonToast`: Sleek feedback widgets.
  * `CommonCard`, `CommonContainer`, `CommonDivider`: Consistent container styling and separators.
  * `ResponsiveHelper` & `ResponsiveLayout`: Adaptive layouts across mobile, tablet, and desktop.
* **🛡️ Centralized Error Handling**:
  * `AppError` and `ErrorHandler` converting Dio, socket, format, and network errors into user-friendly messages.
* **🛠️ Essential Utilities & Validators**:
  * `Validators`: Composable validation for email, phone, passwords, min/max length, required, URLs.
  * `JsonUtils`: Crash-free safe parsing for JSON values.
  * `DateTimeUtils` & `CurrencyUtils`: Human-readable dates, relative "time ago", and currency formatting.
  * `Debouncer` & `Throttler`: Control search typing and rapid button clicks.
  * `ContextExtensions`: Quick access to theme, screen dimensions, navigation, and SnackBars.

---

## 📦 Installation

Add `flutter_common_kit` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_common_kit: ^0.0.1
```

Or run:

```bash
flutter pub add flutter_common_kit
```

---

## 🏁 Quick Start & Initialization

Initialize the kit in your `main()` before running your app:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_common_kit/flutter_common_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FlutterCommonKit.initialize(
    config: const CommonKitConfig(
      appName: 'My Awesome App',
      baseUrl: 'https://api.example.com',
      enableLogging: true, // Debug logging only
      primaryColor: Color(0xFF2563EB),
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Awesome App',
      theme: CommonTheme.lightTheme(FlutterCommonKit.config),
      darkTheme: CommonTheme.darkTheme(FlutterCommonKit.config),
      home: const HomeScreen(),
    );
  }
}
```

---

## 📖 Usage Guide

### 1. API Service (Dio)

Make safe, clean network calls without repeating try-catch blocks:

```dart
// GET Request
final result = await FlutterCommonKit.api.get<UserProfile>(
  '/users/profile',
  decoder: (json) => UserProfile.fromJson(json),
);

result.when(
  success: (response) {
    print('User: ${response.data?.name}');
  },
  failure: (error) {
    print('Error (${error.statusCode}): ${error.message}');
  },
);

// POST Request
final postResult = await FlutterCommonKit.api.post(
  '/users/create',
  data: {'name': 'John Doe', 'role': 'Engineer'},
);

// File Upload
final uploadResult = await FlutterCommonKit.api.uploadFile(
  '/upload/avatar',
  file: File('/path/to/image.png'),
  fileFieldName: 'avatar',
  onSendProgress: (sent, total) {
    print('Uploaded: ${(sent / total * 100).toStringAsFixed(0)}%');
  },
);

// File Download
final downloadResult = await FlutterCommonKit.api.downloadFile(
  'https://example.com/file.pdf',
  savePath: '/local/path/file.pdf',
  onReceiveProgress: (received, total) {
    print('Downloaded: ${(received / total * 100).toStringAsFixed(0)}%');
  },
);
```

---

### 2. Local & Secure Storage

Separate non-sensitive app settings from sensitive tokens:

```dart
// General Local Storage (SharedPreferences)
await FlutterCommonKit.storage.setString('theme_mode', 'dark');
final theme = FlutterCommonKit.storage.getString('theme_mode', 'light');

await FlutterCommonKit.storage.setJson('user_filter', {'active': true});
final filter = FlutterCommonKit.storage.getJson('user_filter');

// Encrypted Secure Storage (Keystore / Keychain)
await FlutterCommonKit.secureStorage.write('api_secret_key', 's3cr3t_v4lu3');
final secret = await FlutterCommonKit.secureStorage.read('api_secret_key');

// Authentication Session Helper
await FlutterCommonKit.auth.saveTokens(
  accessToken: 'eyJhbGciOi...',
  refreshToken: 'dGhpc2lzcmVmcmVzaA...',
);
final accessToken = await FlutterCommonKit.auth.getAccessToken();

// Logout: cleans tokens and session state
await FlutterCommonKit.auth.clearAuthData();
```

---

### 3. Internet Connectivity

Check status synchronously, stream changes, or guard widgets:

```dart
// Synchronous & Direct Check
bool online = FlutterCommonKit.connectivity.isOnline;
bool realAccess = await FlutterCommonKit.connectivity.checkInternet();

// Stream
FlutterCommonKit.connectivity.onConnectivityChanged.listen((isOnline) {
  print('Network status changed: $isOnline');
});

// Connectivity Listener Widget (Wraps your app or screen)
ConnectivityListenerWidget(
  connectivityService: FlutterCommonKit.connectivity,
  showOfflineBanner: true,
  child: const HomeScreen(),
);
```

---

### 4. Common UI Components

#### Buttons
```dart
// Primary Button with loading state
CommonButton(
  text: 'Sign In',
  isLoading: _isLoading,
  icon: const Icon(Icons.login, color: Colors.white, size: 18),
  onPressed: _signIn,
);

// Outlined Button
CommonOutlinedButton(
  text: 'Cancel',
  onPressed: () => Navigator.pop(context),
);

// Secondary Button
CommonButton.secondary(
  text: 'Skip',
  onPressed: () {},
);
```

#### Form Fields & Validators
```dart
CommonTextField(
  controller: _emailController,
  label: 'Email',
  hint: 'Enter your email',
  prefixIcon: const Icon(Icons.email_outlined),
  validator: Validators.compose([
    Validators.required,
    Validators.email,
  ]),
);

CommonPasswordField(
  controller: _passwordController,
  validator: Validators.password,
);
```

#### Feedback, Dialogs & SnackBars
```dart
// Confirmation Dialog
final confirmed = await CommonDialogs.confirm(
  context,
  title: 'Delete Item',
  message: 'Are you sure you want to proceed?',
  isDestructive: true,
);

// Modal Bottom Sheet
CommonBottomSheet.show(
  context,
  title: 'Filters',
  child: const FilterForm(),
);

// Snackbars
CommonSnackbar.showSuccess(context, message: 'Saved successfully!');
CommonSnackbar.showError(context, message: 'An error occurred.');
CommonSnackbar.showToast(context, message: 'Copied to clipboard');
```

#### State & Placeholder Widgets
```dart
// Error Widget with Retry
CommonErrorWidget(
  message: 'Could not connect to server',
  onRetry: () => _fetchData(),
);

// Empty State Widget
CommonEmptyWidget(
  title: 'No Orders Yet',
  message: 'Your recent purchases will appear here.',
  actionText: 'Shop Now',
  onAction: () => _openStore(),
);

// Shimmer Placeholders
const CommonShimmerListTile();
const CommonShimmerCard();
```

---

### 5. Utilities & Extensions

```dart
// Date Formatting & Relative Time
DateTimeUtils.format(DateTime.now(), format: 'dd MMM yyyy'); // "23 Oct 2026"
DateTimeUtils.timeAgo(createdAt); // "5 minutes ago"

// Currency Formatting
CurrencyUtils.format(1450.75, symbol: '₹'); // "₹1,450.75"
CurrencyUtils.formatCompact(1500000); // "1.5M"

// Safe JSON Parsing (Never crashes on null or type mismatch)
int count = JsonUtils.safeInt(json['count']);
String name = JsonUtils.safeString(json['name'], 'Anonymous');

// Debouncer
final debouncer = Debouncer(delay: const Duration(milliseconds: 300));
debouncer.run(() => searchApi(query));

// BuildContext Extensions
context.push(const ProfileScreen());
context.pop();
context.hideKeyboard();
bool isMobile = context.isMobile;
```

---

## 📱 Platform Configuration Notes

* **Android / iOS Secure Storage**:
  `flutter_secure_storage` uses Keychain on iOS and EncryptedSharedPreferences on Android. On Android, if you use backup options in your `AndroidManifest.xml`, make sure `android:fullBackupContent` is configured to exclude shared preference secrets.
* **App Icon & Name**:
  Changing app icons and native app names at runtime cannot be done purely via Flutter package code across all platforms; use `flutter_launcher_icons` or native configuration for build-time assets.

---

## 🧪 Testing

Run package tests:

```bash
flutter test
```

Run static analysis:

```bash
flutter analyze
```

---

## 📄 License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.
