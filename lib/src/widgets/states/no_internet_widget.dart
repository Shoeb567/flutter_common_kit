import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';
import '../buttons/common_button.dart';

/// Full-screen or inline widget indicating loss of internet access.
class NoInternetWidget extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback? onRetry;
  final String retryText;
  final Widget? icon;

  const NoInternetWidget({
    super.key,
    this.title = 'No Internet Connection',
    this.message = AppConstants.defaultNoInternetMsg,
    this.onRetry,
    this.retryText = 'Check Again',
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
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: CommonColors.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wifi_off_rounded,
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
