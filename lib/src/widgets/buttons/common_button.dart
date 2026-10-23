import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';
import '../../theme/common_text_styles.dart';

/// Customizable primary, secondary, and loading button.
class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? loadingColor;
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final BorderSide? borderSide;

  const CommonButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.loadingColor,
    this.height = AppDimensions.buttonHeightMedium,
    this.width,
    this.borderRadius = AppDimensions.radiusMedium,
    this.padding = AppDimensions.paddingButton,
    this.borderSide,
  });

  /// Factory for secondary button style.
  factory CommonButton.secondary({
    Key? key,
    required String text,
    required VoidCallback? onPressed,
    bool isLoading = false,
    bool isFullWidth = true,
    Widget? icon,
    Color? backgroundColor,
    Color? textColor,
    double height = AppDimensions.buttonHeightMedium,
    double borderRadius = AppDimensions.radiusMedium,
  }) {
    return CommonButton(
      key: key,
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      backgroundColor: backgroundColor ?? CommonColors.slate100,
      textColor: textColor ?? CommonColors.slate800,
      loadingColor: textColor ?? CommonColors.slate800,
      height: height,
      borderRadius: borderRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBgColor = backgroundColor ?? theme.colorScheme.primary;
    final effectiveTextColor = textColor ?? Colors.white;

    final childContent = Row(
      mainAxisSize: isFullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              valueColor: AlwaysStoppedAnimation<Color>(
                loadingColor ?? effectiveTextColor,
              ),
            ),
          )
        else ...[
          if (icon != null) ...[
            icon!,
            const SizedBox(width: AppDimensions.space8),
          ],
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: CommonTextStyles.buttonText.copyWith(
                color: effectiveTextColor,
              ),
            ),
          ),
        ],
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBgColor,
      foregroundColor: effectiveTextColor,
      disabledBackgroundColor: effectiveBgColor.withOpacity(0.5),
      disabledForegroundColor: effectiveTextColor.withOpacity(0.7),
      elevation: 0,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: borderSide ?? BorderSide.none,
      ),
    );

    return SizedBox(
      height: height,
      width: isFullWidth ? double.infinity : width,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: isLoading ? null : onPressed,
        child: childContent,
      ),
    );
  }
}

/// Customizable outlined button.
class CommonOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;
  final Widget? icon;
  final Color? borderColor;
  final Color? textColor;
  final double height;
  final double? width;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  const CommonOutlinedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
    this.borderColor,
    this.textColor,
    this.height = AppDimensions.buttonHeightMedium,
    this.width,
    this.borderRadius = AppDimensions.radiusMedium,
    this.padding = AppDimensions.paddingButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBorderColor = borderColor ?? theme.colorScheme.primary;
    final effectiveTextColor = textColor ?? theme.colorScheme.primary;

    return CommonButton(
      text: text,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
      icon: icon,
      backgroundColor: Colors.transparent,
      textColor: effectiveTextColor,
      loadingColor: effectiveTextColor,
      height: height,
      width: width,
      borderRadius: borderRadius,
      padding: padding,
      borderSide: BorderSide(color: effectiveBorderColor, width: 1.5),
    );
  }
}

/// Customizable text button.
class CommonTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? icon;

  const CommonTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.textColor,
    this.textStyle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveColor = textColor ?? theme.colorScheme.primary;

    if (icon != null) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: Text(
          text,
          style: textStyle ??
              CommonTextStyles.labelLarge.copyWith(color: effectiveColor),
        ),
      );
    }

    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: textStyle ??
            CommonTextStyles.labelLarge.copyWith(color: effectiveColor),
      ),
    );
  }
}
