import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_text_styles.dart';

/// Adaptive or custom loading spinner with optional text message.
class CommonLoader extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;
  final double strokeWidth;

  const CommonLoader({
    super.key,
    this.message,
    this.color,
    this.size = 36.0,
    this.strokeWidth = 3.0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = color ?? theme.colorScheme.primary;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator.adaptive(
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(effectiveColor),
            ),
          ),
          if (message != null && message!.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.space12),
            Text(
              message!,
              style: CommonTextStyles.bodyMedium.copyWith(
                color: theme.textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
