import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';
import '../../theme/common_colors.dart';

/// Highly customizable card widget with optional border, elevation, and click handler.
class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final Color? color;
  final double elevation;
  final double borderRadius;
  final BorderSide? border;
  final VoidCallback? onTap;

  const CommonCard({
    super.key,
    required this.child,
    this.padding = AppDimensions.paddingCard,
    this.margin = EdgeInsets.zero,
    this.color,
    this.elevation = 0,
    this.borderRadius = AppDimensions.radiusLarge,
    this.border,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final defaultBorder = BorderSide(
      color: isDark ? CommonColors.borderDark : CommonColors.borderLight,
      width: 1,
    );

    final card = Card(
      color: color ?? (isDark ? CommonColors.cardDark : Colors.white),
      elevation: elevation,
      margin: margin,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: border ?? defaultBorder,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(borderRadius),
        child: card,
      );
    }

    return card;
  }
}
