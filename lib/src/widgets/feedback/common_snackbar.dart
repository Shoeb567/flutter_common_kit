import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';

/// Pre-styled SnackBars and floating toasts.
class CommonSnackbar {
  CommonSnackbar._();

  /// Displays a floating success SnackBar.
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title,
      backgroundColor: CommonColors.success,
      icon: Icons.check_circle_outline,
      duration: duration,
      action: action,
    );
  }

  /// Displays a floating error SnackBar.
  static void showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title,
      backgroundColor: CommonColors.error,
      icon: Icons.error_outline,
      duration: duration,
      action: action,
    );
  }

  /// Displays a floating warning SnackBar.
  static void showWarning(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title,
      backgroundColor: CommonColors.warning,
      icon: Icons.warning_amber_rounded,
      duration: duration,
      action: action,
    );
  }

  /// Displays a floating informational SnackBar.
  static void showInfo(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
  }) {
    _showCustomSnackBar(
      context,
      message: message,
      title: title,
      backgroundColor: CommonColors.info,
      icon: Icons.info_outline,
      duration: duration,
      action: action,
    );
  }

  /// Displays a lightweight floating toast pill.
  static void showToast(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: CommonTextStyles.bodyMedium.copyWith(color: Colors.white),
        ),
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusCircular),
        ),
        backgroundColor: CommonColors.slate800.withOpacity(0.9),
        margin: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      ),
    );
  }

  static void _showCustomSnackBar(
    BuildContext context, {
    required String message,
    String? title,
    required Color backgroundColor,
    required IconData icon,
    required Duration duration,
    SnackBarAction? action,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: AppDimensions.space12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (title != null) ...[
                    Text(
                      title,
                      style: CommonTextStyles.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    message,
                    style: CommonTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        margin: const EdgeInsets.all(AppDimensions.space16),
      ),
    );
  }
}
