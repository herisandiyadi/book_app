import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Futuristic Color palette
const Color kNeonBlue = Color(0xFF00FFF7);
const Color kDeepNavy = Color(0xFF0A0F2C);
const Color kElectricPurple = Color(0xFF9D00FF);
const Color kCharcoal = Color(0xFF181A2A);
const Color kNeonMagenta = Color(0xFFFF005C);

/// App ColorScheme (Dark)
const ColorScheme appColorSchemeDark = ColorScheme(
  brightness: Brightness.dark,
  primary: kNeonBlue,
  onPrimary: kDeepNavy,
  secondary: kElectricPurple,
  onSecondary: kNeonBlue,
  background: kDeepNavy,
  onBackground: kNeonBlue,
  surface: kCharcoal,
  onSurface: kNeonBlue,
  error: kNeonMagenta,
  onError: Colors.white,
);

/// App ColorScheme (Light)
const ColorScheme appColorSchemeLight = ColorScheme(
  brightness: Brightness.light,
  primary: kElectricPurple,
  onPrimary: Colors.white,
  secondary: kNeonBlue,
  onSecondary: kDeepNavy,
  background: Colors.white,
  onBackground: kDeepNavy,
  surface: Color(0xFFF2F6FF),
  onSurface: kDeepNavy,
  error: kNeonMagenta,
  onError: Colors.white,
);

/// App ThemeData (Dark)
final ThemeData appThemeDark = ThemeData(
  colorScheme: appColorSchemeDark,
  scaffoldBackgroundColor: appColorSchemeDark.background,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: kNeonBlue,
    displayColor: kNeonBlue,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kCharcoal,
    foregroundColor: kNeonBlue,
    elevation: 0,
    iconTheme: const IconThemeData(color: kNeonBlue),
    titleTextStyle: const TextStyle(
      color: kNeonBlue,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 1.2,
      shadows: [
        Shadow(color: kElectricPurple, blurRadius: 8, offset: Offset(0, 2)),
      ],
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kElectricPurple,
    foregroundColor: kNeonBlue,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kNeonBlue,
      foregroundColor: kDeepNavy,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        shadows: [
          Shadow(color: kElectricPurple, blurRadius: 6, offset: Offset(0, 1)),
        ],
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kElectricPurple,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kCharcoal,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: kNeonBlue),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: kElectricPurple, width: 2),
    ),
    labelStyle: const TextStyle(color: kNeonBlue),
    hintStyle: const TextStyle(color: kElectricPurple),
  ),
  iconTheme: const IconThemeData(color: kNeonBlue),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kElectricPurple,
  ),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kNeonMagenta,
    contentTextStyle: TextStyle(color: kNeonBlue),
  ),
  cardTheme: CardThemeData(
    color: kCharcoal,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: kElectricPurple.withOpacity(0.2),
  ),
  dividerColor: kElectricPurple,
  useMaterial3: true,
);

/// App ThemeData (Light)
final ThemeData appThemeLight = ThemeData(
  colorScheme: appColorSchemeLight,
  scaffoldBackgroundColor: appColorSchemeLight.background,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: kDeepNavy,
    displayColor: kDeepNavy,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: appColorSchemeLight.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 20,
      letterSpacing: 1.2,
      shadows: [Shadow(color: kNeonBlue, blurRadius: 8, offset: Offset(0, 2))],
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kNeonBlue,
    foregroundColor: kDeepNavy,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kElectricPurple,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
        shadows: [
          Shadow(color: kNeonBlue, blurRadius: 6, offset: Offset(0, 1)),
        ],
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kNeonBlue,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        letterSpacing: 1.1,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: appColorSchemeLight.surface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: kElectricPurple),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: kNeonBlue, width: 2),
    ),
    labelStyle: const TextStyle(color: kDeepNavy),
    hintStyle: const TextStyle(color: kElectricPurple),
  ),
  iconTheme: const IconThemeData(color: kElectricPurple),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: kNeonBlue),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kNeonMagenta,
    contentTextStyle: TextStyle(color: kDeepNavy),
  ),
  cardTheme: CardThemeData(
    color: appColorSchemeLight.surface,
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadowColor: kNeonBlue.withOpacity(0.12),
  ),
  dividerColor: kNeonBlue,
  useMaterial3: true,
);
