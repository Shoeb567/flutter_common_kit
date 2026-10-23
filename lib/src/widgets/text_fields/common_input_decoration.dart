import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';

/// Helper class to create customizable, consistent [InputDecoration].
class CommonInputDecoration {
  CommonInputDecoration._();

  static InputDecoration create({
    String? hintText,
    String? labelText,
    String? helperText,
    String? errorText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color? fillColor,
    bool filled = true,
    double borderRadius = AppDimensions.radiusMedium,
    Color? borderColor,
    Color? focusedBorderColor,
    EdgeInsetsGeometry? contentPadding,
  }) {
    final effectiveBorderColor = borderColor ?? CommonColors.borderLight;
    final effectiveRadius = BorderRadius.circular(borderRadius);

    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      helperText: helperText,
      errorText: errorText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: filled,
      fillColor: fillColor,
      contentPadding: contentPadding ??
          const EdgeInsets.symmetric(
            horizontal: AppDimensions.space16,
            vertical: AppDimensions.space14,
          ),
      border: OutlineInputBorder(
        borderRadius: effectiveRadius,
        borderSide: BorderSide(color: effectiveBorderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: effectiveRadius,
        borderSide: BorderSide(color: effectiveBorderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: effectiveRadius,
        borderSide: BorderSide(
          color: focusedBorderColor ?? CommonColors.primary,
          width: 1.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: effectiveRadius,
        borderSide: const BorderSide(color: CommonColors.error),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: effectiveRadius,
        borderSide: const BorderSide(color: CommonColors.error, width: 1.5),
      ),
    );
  }
}
