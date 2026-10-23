import 'package:flutter/material.dart';

/// Helpful extensions on numeric types for layout spacing.
extension NumExtensions on num {
  /// Vertical spacing widget: `SizedBox(height: this)`.
  Widget get verticalSpace => SizedBox(height: toDouble());

  /// Horizontal spacing widget: `SizedBox(width: this)`.
  Widget get horizontalSpace => SizedBox(width: toDouble());

  /// Symmetrical vertical edge insets.
  EdgeInsets get verticalPadding => EdgeInsets.symmetric(vertical: toDouble());

  /// Symmetrical horizontal edge insets.
  EdgeInsets get horizontalPadding => EdgeInsets.symmetric(horizontal: toDouble());

  /// All-around edge insets.
  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  /// Circular border radius.
  BorderRadius get circularRadius => BorderRadius.circular(toDouble());
}
