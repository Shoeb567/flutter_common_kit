import 'package:flutter/material.dart';
import '../config/common_kit_config.dart';
import '../constants/app_dimensions.dart';
import 'common_colors.dart';
import 'common_text_styles.dart';

/// Helper to generate consistent Material 3 light and dark themes
/// based on [CommonKitConfig].
class CommonTheme {
  CommonTheme._();

  /// Builds the light theme based on configuration.
  static ThemeData lightTheme([CommonKitConfig? config]) {
    final cfg = config ?? const CommonKitConfig();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: cfg.primaryColor,
      brightness: Brightness.light,
      primary: cfg.primaryColor,
      secondary: cfg.secondaryColor,
      surface: cfg.lightScaffoldColor,
      error: CommonColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: cfg.lightScaffoldColor,
      fontFamily: null,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: CommonColors.slate900,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: CommonTextStyles.titleLarge.copyWith(
          color: CommonColors.slate900,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cfg.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: CommonTextStyles.buttonText,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cfg.primaryColor,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMedium),
          side: BorderSide(color: cfg.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: CommonTextStyles.buttonText,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          side: const BorderSide(color: CommonColors.borderLight, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: cfg.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.error, width: 1.5),
        ),
        hintStyle: CommonTextStyles.bodyMedium.copyWith(
          color: CommonColors.slate400,
        ),
        labelStyle: CommonTextStyles.bodyMedium.copyWith(
          color: CommonColors.slate600,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: CommonColors.borderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }

  /// Builds the dark theme based on configuration.
  static ThemeData darkTheme([CommonKitConfig? config]) {
    final cfg = config ?? const CommonKitConfig();
    final colorScheme = ColorScheme.fromSeed(
      seedColor: cfg.primaryColor,
      brightness: Brightness.dark,
      primary: cfg.primaryColor,
      secondary: cfg.secondaryColor,
      surface: cfg.darkScaffoldColor,
      error: CommonColors.error,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: cfg.darkScaffoldColor,
      fontFamily: null,
      appBarTheme: AppBarTheme(
        backgroundColor: cfg.darkScaffoldColor,
        foregroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        titleTextStyle: CommonTextStyles.titleLarge.copyWith(
          color: Colors.white,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cfg.primaryColor,
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: CommonTextStyles.buttonText,
          elevation: 0,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          minimumSize: const Size.fromHeight(AppDimensions.buttonHeightMedium),
          side: BorderSide(color: cfg.primaryColor, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          ),
          textStyle: CommonTextStyles.buttonText,
        ),
      ),
      cardTheme: CardThemeData(
        color: CommonColors.cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
          side: const BorderSide(color: CommonColors.borderDark, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CommonColors.slate800,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.space16,
          vertical: AppDimensions.space16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: BorderSide(color: cfg.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
          borderSide: const BorderSide(color: CommonColors.error, width: 1.5),
        ),
        hintStyle: CommonTextStyles.bodyMedium.copyWith(
          color: CommonColors.slate500,
        ),
        labelStyle: CommonTextStyles.bodyMedium.copyWith(
          color: CommonColors.slate300,
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: CommonColors.borderDark,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
