import 'package:flutter/material.dart';
import '../../constants/app_dimensions.dart';

/// Screen device type categorization.
enum ScreenType {
  mobile,
  tablet,
  desktop,
}

/// Helper methods for determining screen form factors and breakpoints.
class ResponsiveHelper {
  ResponsiveHelper._();

  /// Gets current screen type based on width.
  static ScreenType getScreenType(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < AppDimensions.mobileBreakpoint) {
      return ScreenType.mobile;
    } else if (width < AppDimensions.tabletBreakpoint) {
      return ScreenType.tablet;
    } else {
      return ScreenType.desktop;
    }
  }

  /// Returns true if device is classified as mobile.
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < AppDimensions.mobileBreakpoint;

  /// Returns true if device is classified as tablet.
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= AppDimensions.mobileBreakpoint &&
        width < AppDimensions.tabletBreakpoint;
  }

  /// Returns true if device is classified as desktop/web landscape.
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= AppDimensions.tabletBreakpoint;

  /// Returns appropriate value based on current screen type.
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    final type = getScreenType(context);
    switch (type) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}

/// Responsive widget builder that adapts automatically to mobile, tablet, and desktop layouts.
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final type = ResponsiveHelper.getScreenType(context);
    switch (type) {
      case ScreenType.mobile:
        return mobile;
      case ScreenType.tablet:
        return tablet ?? mobile;
      case ScreenType.desktop:
        return desktop ?? tablet ?? mobile;
    }
  }
}
