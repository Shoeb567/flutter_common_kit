import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';
import '../buttons/common_button.dart';

/// Reusable empty state placeholder widget.
class CommonEmptyWidget extends StatelessWidget {
  final String title;
  final String? message;
  final Widget? icon;
  final String? actionText;
  final VoidCallback? onAction;

  const CommonEmptyWidget({
    super.key,
    this.title = 'No Data Found',
    this.message,
    this.icon,
    this.actionText,
    this.onAction,
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
                    color: CommonColors.slate100,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.inbox_outlined,
                    color: CommonColors.slate400,
                    size: 44,
                  ),
                ),
            const SizedBox(height: AppDimensions.space20),
            Text(
              title,
              style: CommonTextStyles.headlineMedium,
              textAlign: TextAlign.center,
            ),
            if (message != null && message!.isNotEmpty) ...[
              const SizedBox(height: AppDimensions.space8),
              Text(
                message!,
                style: CommonTextStyles.bodyMedium.copyWith(
                  color: CommonColors.slate500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: AppDimensions.space24),
              CommonButton(
                text: actionText!,
                onPressed: onAction,
                isFullWidth: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
