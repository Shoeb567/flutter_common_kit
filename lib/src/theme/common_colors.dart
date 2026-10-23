import 'package:flutter/material.dart';

/// Predefined modern, curated color palette with accessible contrast.
class CommonColors {
  CommonColors._();

  // Primary Shades
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue 700
  static const Color primaryLight = Color(0xFF60A5FA); // Blue 400
  static const Color primaryContainer = Color(0xFFDBEAFE); // Blue 100

  // Secondary Shades
  static const Color secondary = Color(0xFF10B981); // Emerald 500
  static const Color secondaryDark = Color(0xFF047857); // Emerald 700
  static const Color secondaryLight = Color(0xFF34D399); // Emerald 400

  // Feedback Colors
  static const Color success = Color(0xFF10B981);
  static const Color successContainer = Color(0xFFD1FAE5);
  static const Color error = Color(0xFFEF4444);
  static const Color errorContainer = Color(0xFFFEE2E2);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoContainer = Color(0xFFDBEAFE);

  // Neutral Grayscale
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

  // Surfaces
  static const Color surfaceLight = Colors.white;
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color cardDark = Color(0xFF1E293B);

  // Border & Divider
  static const Color borderLight = Color(0xFFE2E8F0);
  static const Color borderDark = Color(0xFF334155);
}
