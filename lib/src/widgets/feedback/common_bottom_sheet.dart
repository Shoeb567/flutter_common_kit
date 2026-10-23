import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';

/// Modal bottom sheet utility with drag handle and modern styling.
class CommonBottomSheet {
  CommonBottomSheet._();

  /// Displays a modal bottom sheet with optional title and close action.
  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    bool isScrollControlled = true,
    double? maxHeightRatio = 0.85,
    EdgeInsetsGeometry? padding,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: isScrollControlled,
      backgroundColor: isDark ? CommonColors.slate900 : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusExtraLarge),
        ),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeightRatio != null
                    ? MediaQuery.of(ctx).size.height * maxHeightRatio
                    : double.infinity,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: AppDimensions.space8),
                  // Drag handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isDark ? CommonColors.slate700 : CommonColors.slate300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  if (title != null) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.space20,
                        vertical: AppDimensions.space12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: CommonTextStyles.titleMedium,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close, size: 20),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                  Flexible(
                    child: SingleChildScrollView(
                      padding: padding ?? AppDimensions.paddingScreen,
                      child: child,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
