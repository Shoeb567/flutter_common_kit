import 'package:flutter/material.dart';
import '../../theme/common_colors.dart';

/// Customizable horizontal divider with default responsive styling.
class CommonDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  const CommonDivider({
    super.key,
    this.height = 1.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? CommonColors.borderDark : CommonColors.borderLight);

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: effectiveColor,
    );
  }
}

/// Customizable vertical divider with default responsive styling.
class CommonVerticalDivider extends StatelessWidget {
  final double width;
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  const CommonVerticalDivider({
    super.key,
    this.width = 1.0,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveColor = color ??
        (isDark ? CommonColors.borderDark : CommonColors.borderLight);

    return VerticalDivider(
      width: width,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: effectiveColor,
    );
  }
}
