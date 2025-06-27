import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Color palette
const Color kDarkMossGreen = Color(0xFF606C38);
const Color kPakistanGreen = Color(0xFF283618);
const Color kCornsilk = Color(0xFFFEFAE0);
const Color kEarthYellow = Color(0xFFDDA15E);
const Color kTigersEye = Color(0xFFBC6C25);

/// App ColorScheme
const ColorScheme appColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: kDarkMossGreen,
  onPrimary: kCornsilk,
  secondary: kEarthYellow,
  onSecondary: kPakistanGreen,
  background: kCornsilk,
  onBackground: kPakistanGreen,
  surface: Colors.white,
  onSurface: kPakistanGreen,
  error: kTigersEye,
  onError: Colors.white,
);

/// App ThemeData
final ThemeData appTheme = ThemeData(
  colorScheme: appColorScheme,
  scaffoldBackgroundColor: appColorScheme.background,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: GoogleFonts.poppinsTextTheme(),
  appBarTheme: AppBarTheme(
    backgroundColor: kDarkMossGreen,
    foregroundColor: kCornsilk,
    elevation: 0,
    iconTheme: const IconThemeData(color: kCornsilk),
    titleTextStyle: const TextStyle(
      color: kCornsilk,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: kEarthYellow,
    foregroundColor: kPakistanGreen,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kDarkMossGreen,
      foregroundColor: kCornsilk,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: kDarkMossGreen,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: kCornsilk,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kDarkMossGreen),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: kEarthYellow, width: 2),
    ),
    labelStyle: const TextStyle(color: kPakistanGreen),
    hintStyle: const TextStyle(color: kPakistanGreen),
  ),
  iconTheme: const IconThemeData(color: kDarkMossGreen),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: kEarthYellow),
  snackBarTheme: const SnackBarThemeData(
    backgroundColor: kTigersEye,
    contentTextStyle: TextStyle(color: kCornsilk),
  ),
  cardTheme: CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  ),
  dividerColor: kEarthYellow,
  useMaterial3: true,
);
