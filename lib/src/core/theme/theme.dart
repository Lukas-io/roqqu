import 'package:flutter/material.dart';

import '../constants.dart';
import 'color.dart';

class RoqquTheme {
  static final ThemeData appTheme = ThemeData(
    fontFamily: ModernConstants.fontFamily,
    colorScheme: ColorScheme.fromSeed(
      seedColor: RoqquColors.primary,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: RoqquColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: RoqquColors.background,
      surfaceTintColor: Colors.transparent,
      // Instant app bar transitions
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    inputDecorationTheme: InputDecorationThemeData(),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16),

        textStyle: TextStyle(
          fontFamily: ModernConstants.fontFamily,

          color: RoqquColors.white,

          fontSize: 18,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4),
        ),
        textStyle: TextStyle(
          fontFamily: ModernConstants.fontFamily,

          color: RoqquColors.white,
          fontSize: 18,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
