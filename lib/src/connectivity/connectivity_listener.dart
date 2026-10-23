import 'package:flutter/material.dart';
import 'connectivity_service.dart';

/// Widget wrapper that listens to connectivity changes and can display
/// an offline banner or a replacement screen when disconnected.
class ConnectivityListenerWidget extends StatelessWidget {
  final ConnectivityService connectivityService;
  final Widget child;
  final Widget? offlineWidget;
  final bool showOfflineBanner;
  final VoidCallback? onReconnected;

  const ConnectivityListenerWidget({
    super.key,
    required this.connectivityService,
    required this.child,
    this.offlineWidget,
    this.showOfflineBanner = true,
    this.onReconnected,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: connectivityService.onConnectivityChanged,
      initialData: connectivityService.isOnline,
      builder: (context, snapshot) {
        final isOnline = snapshot.data ?? true;

        if (!isOnline && offlineWidget != null) {
          return offlineWidget!;
        }

        return Stack(
          children: [
            child,
            if (!isOnline && showOfflineBanner)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Material(
                  color: Colors.red.shade700,
                  elevation: 4,
                  child: SafeArea(
                    bottom: false,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      alignment: Alignment.center,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.wifi_off, color: Colors.white, size: 16),
                          SizedBox(width: 8),
                          Text(
                            'No Internet Connection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
