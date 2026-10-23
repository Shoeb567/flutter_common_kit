import 'package:flutter/widgets.dart';
import 'config/common_kit_config.dart';
import 'connectivity/connectivity_service.dart';
import 'network/api_service.dart';
import 'storage/auth_storage_helper.dart';
import 'storage/secure_storage_service.dart';
import 'storage/storage_service.dart';
import 'utils/app_logger.dart';

/// Central singleton and initialization hub for the FlutterCommonKit package.
class FlutterCommonKit {
  FlutterCommonKit._();

  static CommonKitConfig _config = const CommonKitConfig();
  static late StorageService _storageService;
  static late SecureStorageService _secureStorageService;
  static late AuthStorageHelper _authStorageHelper;
  static late ApiService _apiService;
  static late ConnectivityService _connectivityService;
  static bool _isInitialized = false;

  /// Whether the package has been initialized.
  static bool get isInitialized => _isInitialized;

  /// Active configuration.
  static CommonKitConfig get config => _config;

  /// Global centralized [ApiService] instance.
  static ApiService get api {
    _checkInitialized();
    return _apiService;
  }

  /// Global centralized [StorageService] instance (SharedPreferences).
  static StorageService get storage {
    _checkInitialized();
    return _storageService;
  }

  /// Global centralized [SecureStorageService] instance (Encrypted Keystore/Keychain).
  static SecureStorageService get secureStorage {
    _checkInitialized();
    return _secureStorageService;
  }

  /// Global [AuthStorageHelper] instance coordinating credentials.
  static AuthStorageHelper get auth {
    _checkInitialized();
    return _authStorageHelper;
  }

  /// Global [ConnectivityService] instance.
  static ConnectivityService get connectivity {
    _checkInitialized();
    return _connectivityService;
  }

  /// Initializes all package subsystems (storage, network, connectivity, logging).
  ///
  /// ```dart
  /// void main() async {
  ///   WidgetsFlutterBinding.ensureInitialized();
  ///   await FlutterCommonKit.initialize(
  ///     config: CommonKitConfig(
  ///       baseUrl: 'https://api.example.com',
  ///       enableLogging: true,
  ///     ),
  ///   );
  ///   runApp(const MyApp());
  /// }
  /// ```
  static Future<void> initialize({
    CommonKitConfig config = const CommonKitConfig(),
    StorageService? storageService,
    SecureStorageService? secureStorageService,
    ConnectivityService? connectivityService,
    ApiService? apiService,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    _config = config;
    AppLogger.isEnabled = config.enableLogging;

    // 1. Storage
    _storageService = storageService ?? await StorageService.init();
    _secureStorageService = secureStorageService ?? SecureStorageService();
    _authStorageHelper = AuthStorageHelper(
      storageService: _storageService,
      secureStorageService: _secureStorageService,
    );

    // 2. Network Client
    _apiService = apiService ??
        ApiService(
          config: config.copyWith(
            tokenProvider: config.tokenProvider ?? _authStorageHelper.getAccessToken,
          ),
        );

    // 3. Connectivity Service
    _connectivityService = connectivityService ?? ConnectivityService();
    await _connectivityService.initialize();

    _isInitialized = true;
    AppLogger.info('FlutterCommonKit initialized successfully.');
  }

  static void _checkInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'FlutterCommonKit is not initialized. Please call `await FlutterCommonKit.initialize()` in your main() function before accessing services.',
      );
    }
  }

  /// Reset internal state (useful for tests).
  @visibleForTesting
  static void resetForTesting() {
    _isInitialized = false;
  }
}

/// Convenience alias for [FlutterCommonKit]
typedef CommonFlutter = FlutterCommonKit;

/// Convenience alias for [CommonKitConfig]
typedef CommonFlutterConfig = CommonKitConfig;
