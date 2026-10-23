import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

/// Service managing device network state and verifying actual internet access.
class ConnectivityService {
  final Connectivity _connectivity;
  final StreamController<bool> _connectionChangeController =
      StreamController<bool>.broadcast();

  bool _isOnline = true;
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  ConnectivityService({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  /// Stream of boolean values indicating whether internet is available.
  Stream<bool> get onConnectivityChanged => _connectionChangeController.stream;

  /// Cached synchronous state of internet connectivity.
  bool get isOnline => _isOnline;

  /// Initializes listening to network interface changes.
  Future<void> initialize() async {
    final initialResults = await _connectivity.checkConnectivity();
    _isOnline = await _verifyActualInternet(initialResults);

    _subscription = _connectivity.onConnectivityChanged.listen((results) async {
      final hasAccess = await _verifyActualInternet(results);
      if (_isOnline != hasAccess) {
        _isOnline = hasAccess;
        _connectionChangeController.add(_isOnline);
      }
    });
  }

  /// Verifies active network interface and performs a real DNS lookup check.
  Future<bool> _verifyActualInternet(List<ConnectivityResult> results) async {
    final hasInterface = results.any((r) => r != ConnectivityResult.none);
    if (!hasInterface) return false;

    // In web, socket lookups are not supported, so interface check is sufficient
    if (kIsWeb) return true;

    try {
      final lookup = await InternetAddress.lookup('dns.google')
          .timeout(const Duration(seconds: 4));
      return lookup.isNotEmpty && lookup[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Manually checks if the device currently has verifiable internet access.
  Future<bool> checkInternet() async {
    final results = await _connectivity.checkConnectivity();
    final online = await _verifyActualInternet(results);
    _isOnline = online;
    return online;
  }

  /// Disposes background streams.
  void dispose() {
    _subscription?.cancel();
    _connectionChangeController.close();
  }
}
