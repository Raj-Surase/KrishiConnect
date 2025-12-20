import 'dart:ui';

import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

class AppColors {
  // helper
  static Color hsl(double h, double s, double l, {double a = 1.0}) =>
      HSLColor.fromAHSL(a, h, s, l).toColor();

  // ----------------------
  // Light Theme Colors
  // ----------------------

  /// #1A3C34 → deep green
  static final lightPrimary = hsl(154, 0.7, 0.23);
  static final lightOnPrimary = hsl(0, 0, 1.0);

  /// #DDECE8 → soft mint
  static final lightPrimaryContainer = hsl(165, 0.32, 0.90);
  static final lightOnPrimaryContainer = hsl(165, 0.38, 0.16);

  /// #0096E3 → ocean blue
  static final lightSecondary = hsl(199, 0.8, 0.45);
  static final lightOnSecondary = hsl(0, 0, 1.0);

  /// #E0F4FF → very light blue
  static final lightSecondaryContainer = hsl(199, 1.0, 0.94);
  static final lightOnSecondaryContainer = hsl(199, 1.0, 0.45);

  /// #F5FAFC → light sky gray-blue
  static final lightBackground = hsl(0, 0, 0.9);
  static final lightOnBackground = hsl(0, 0, 0.05);

  static final lightSurface = hsl(0, 0, 0.95);
  static final lightOnSurface = hsl(0, 0, 0.2);

  static final lightSurfaceContainer = hsl(0, 0, 0.98);

  /// #A9A8A8 → neutral border gray
  static final lightBorder = hsl(0, 0, 0.66);

  /// #E0E0E0 → light gray
  static final lightSurfaceVariant = hsl(0, 0, 0.9);
  static final lightOnSurfaceVariant = hsl(0, 0, 0.34);

  // Error (light)
  static final lightError = hsl(4, 0.72, 0.46);
  static final lightOnError = hsl(0, 0, 1.0);

  // Error container (light)
  static final lightErrorContainer = hsl(4, 0.85, 0.92);
  static final lightOnErrorContainer = hsl(4, 0.75, 0.25);

  // Tertiary (light)
  static final lightTertiary = hsl(48, 0.85, 0.48);
  static final lightOnTertiary = hsl(48, 1.0, 0.12);

  // Tertiary container (light)
  static final lightTertiaryContainer = hsl(48, 0.9, 0.90);
  static final lightOnTertiaryContainer = hsl(48, 0.8, 0.20);

  // ----------------------
  // Dark Theme Colors
  // ----------------------

  /// #88C9B5 → desaturated mint
  static final darkPrimary = hsl(154, 0.7, 0.36);
  static final darkOnPrimary = hsl(0, 0, 0.02);

  /// #005244 → deep green container
  static final darkPrimaryContainer = hsl(165, 1.0, 0.16);
  static final darkOnPrimaryContainer = hsl(165, 1.0, 0.88);

  /// #7CCFFA → sky blue
  static final darkSecondary = hsl(199, 0.92, 0.73);
  static final darkOnSecondary = hsl(199, 1.0, 0.14);

  /// #004D63 → dark aqua
  static final darkSecondaryContainer = hsl(194, 1.0, 0.20);
  static final darkOnSecondaryContainer = hsl(199, 1.0, 0.88);

  /// #0F1416 → deep charcoal blue
  static final darkBackground = hsl(0, 0, 0);
  static final darkOnBackground = hsl(0, 0, 0.95);

  /// #2A2A2A → dark neutral surface
  static final darkSurface = hsl(0, 0, 0.1);
  static final darkOnSurface = hsl(0, 0, 0.7);

  static final darkSurfaceContainer = hsl(0, 0, 0.2);

  /// #575757 → dark gray border
  static final darkBorder = hsl(0, 0, 0.34);

  /// #323232 → slightly lighter gray variant
  static final darkSurfaceVariant = hsl(0, 0, 0.1);
  static final darkOnSurfaceVariant = hsl(0, 0, 0.62);

  // Error (dark)
  static final darkError = hsl(6, 0.85, 0.68);
  static final darkOnError = hsl(6, 1.0, 0.15);

  // Error container (dark)
  static final darkErrorContainer = hsl(6, 0.75, 0.28);
  static final darkOnErrorContainer = hsl(6, 0.9, 0.92);

  // Tertiary (dark)
  static final darkTertiary = hsl(48, 0.75, 0.65);
  static final darkOnTertiary = hsl(48, 1.0, 0.15);

  // Tertiary container (dark)
  static final darkTertiaryContainer = hsl(48, 0.6, 0.30);
  static final darkOnTertiaryContainer = hsl(48, 0.85, 0.90);

  // ----------------------
  // Brand Colors (HSL)
  // ----------------------

  /// #F08100 → orange
  static final orange = hsl(32, 1.0, 0.47);

  /// #F9D001 → yellow
  static final yellow = hsl(51, 1.0, 0.49);
}
