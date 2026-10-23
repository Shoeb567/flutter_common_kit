import 'package:flutter/material.dart';
import '../constants/app_dimensions.dart';

/// Ergonomic extensions on [BuildContext] for theme, media query, and navigation.
extension ContextExtensions on BuildContext {
  // Theme & Colors
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // Media Query & Screen Dimensions
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;
  EdgeInsets get screenPadding => MediaQuery.paddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  // Responsive device checks
  bool get isMobile => screenWidth < AppDimensions.mobileBreakpoint;
  bool get isTablet =>
      screenWidth >= AppDimensions.mobileBreakpoint &&
      screenWidth < AppDimensions.tabletBreakpoint;
  bool get isDesktop => screenWidth >= AppDimensions.tabletBreakpoint;

  // Navigation Helpers
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(
      MaterialPageRoute(builder: (_) => page),
    );
  }

  Future<T?> pushReplacement<T, TO>(Widget page, {TO? result}) {
    return Navigator.of(this).pushReplacement<T, TO>(
      MaterialPageRoute(builder: (_) => page),
      result: result,
    );
  }

  Future<T?> pushNamed<T>(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed<T>(routeName, arguments: arguments);
  }

  void pop<T>([T? result]) {
    if (Navigator.of(this).canPop()) {
      Navigator.of(this).pop<T>(result);
    }
  }

  // Focus & Keyboard
  void hideKeyboard() {
    final currentFocus = FocusScope.of(this);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  // Feedback
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    SnackBar snackBar,
  ) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    return ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
