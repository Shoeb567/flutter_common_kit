import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';
import '../buttons/common_button.dart';

/// Reusable error widget displaying an error message with an optional retry button.
class CommonErrorWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryText;
  final Widget? icon;

  const CommonErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    required this.message,
    this.onRetry,
    this.retryText = 'Try Again',
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: AppDimensions.paddingScreen,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ??
                Container(
                  width: 72,
                  height: 72,
                  decoration: const BoxDecoration(
                    color: CommonColors.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.error_outline_rounded,
                    color: CommonColors.error,
                    size: 40,
                  ),
                ),
            const SizedBox(height: AppDimensions.space20),
            Text(
              title,
              style: CommonTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.space8),
            Text(
              message,
              style: CommonTextStyles.bodyMedium.copyWith(
                color: CommonColors.slate500,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.space24),
              CommonButton(
                text: retryText,
                onPressed: onRetry,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
