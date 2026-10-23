import 'package:flutter/material.dart';

/// Standard spacing and dimension constants used throughout the package.
class AppDimensions {
  AppDimensions._();

  // Spacing / Margins / Paddings
  static const double space2 = 2.0;
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space14 = 14.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;

  // Border Radius
  static const double radiusSmall = 6.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusExtraLarge = 24.0;
  static const double radiusCircular = 999.0;

  // Button Heights
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightMedium = 48.0;
  static const double buttonHeightLarge = 56.0;

  // Input Field Height
  static const double inputFieldHeight = 48.0;

  // Icon Sizes
  static const double iconSmall = 16.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;

  // Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 1024.0;

  // Edge insets presets
  static const EdgeInsets paddingScreen = EdgeInsets.symmetric(
    horizontal: space16,
    vertical: space16,
  );
  static const EdgeInsets paddingCard = EdgeInsets.all(space16);
  static const EdgeInsets paddingButton = EdgeInsets.symmetric(
    horizontal: space20,
    vertical: space12,
  );
}
