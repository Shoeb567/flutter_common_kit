import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';

/// Predefined standard dialog helpers.
class CommonDialogs {
  CommonDialogs._();

  /// Shows a confirmation dialog with Confirm and Cancel buttons.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDestructive = false,
    Widget? icon,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
          icon: icon,
          title: Text(title, style: CommonTextStyles.titleMedium),
          content: Text(message, style: CommonTextStyles.bodyMedium),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(cancelText),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isDestructive
                    ? CommonColors.error
                    : Theme.of(ctx).colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              onPressed: () => Navigator.of(ctx).pop(true),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
    return result ?? false;
  }

  /// Shows an alert dialog with a single acknowledgment button.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = 'OK',
    Widget? icon,
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          ),
          icon: icon,
          title: Text(title, style: CommonTextStyles.titleMedium),
          content: Text(message, style: CommonTextStyles.bodyMedium),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text(buttonText),
            ),
          ],
        );
      },
    );
  }

  /// Shows a custom modal dialog with arbitrary widget body.
  static Future<T?> showCustomDialog<T>(
    BuildContext context, {
    required Widget child,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        ),
        child: child,
      ),
    );
  }
}
