import '../constants/app_constants.dart';
import 'secure_storage_service.dart';
import 'storage_service.dart';

/// Helper to coordinate authentication credentials, user profiles, and session data.
class AuthStorageHelper {
  final StorageService storageService;
  final SecureStorageService secureStorageService;

  AuthStorageHelper({
    required this.storageService,
    required this.secureStorageService,
  });

  /// Persists authentication tokens securely.
  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await secureStorageService.write(AppConstants.keyAccessToken, accessToken);
    if (refreshToken != null) {
      await secureStorageService.write(AppConstants.keyRefreshToken, refreshToken);
    }
    await storageService.setBool(AppConstants.keyIsLoggedIn, true);
  }

  /// Retrieves the current access token.
  Future<String?> getAccessToken() =>
      secureStorageService.read(AppConstants.keyAccessToken);

  /// Retrieves the current refresh token.
  Future<String?> getRefreshToken() =>
      secureStorageService.read(AppConstants.keyRefreshToken);

  /// Saves non-sensitive user profile data.
  Future<bool> saveUserData(Map<String, dynamic> userData) =>
      storageService.setJson(AppConstants.keyUserData, userData);

  /// Retrieves saved user profile data.
  Map<String, dynamic>? getUserData() =>
      storageService.getJson(AppConstants.keyUserData);

  /// Checks if the user is currently logged in.
  bool get isLoggedIn =>
      storageService.getBool(AppConstants.keyIsLoggedIn, false) ?? false;

  /// Clears tokens and session state upon logout.
  Future<void> clearAuthData() async {
    await secureStorageService.delete(AppConstants.keyAccessToken);
    await secureStorageService.delete(AppConstants.keyRefreshToken);
    await storageService.remove(AppConstants.keyUserData);
    await storageService.setBool(AppConstants.keyIsLoggedIn, false);
  }
}
