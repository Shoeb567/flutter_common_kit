import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';

/// Pre-styled container with gradient, border, shadow, and click capabilities.
class CommonContainer extends StatelessWidget {
  final Widget? child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Gradient? gradient;
  final double borderRadius;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final VoidCallback? onTap;
  final AlignmentGeometry? alignment;

  const CommonContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.color,
    this.gradient,
    this.borderRadius = AppDimensions.radiusMedium,
    this.border,
    this.boxShadow,
    this.onTap,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: boxShadow,
    );

    Widget container = Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: container,
      );
    }

    return container;
  }
}
