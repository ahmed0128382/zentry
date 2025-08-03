import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../utils/app_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    fontFamily: AppFonts.primaryFont,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.accent,
    ),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: AppFonts.primaryFont,
    primaryColor: AppColors.primary,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
      labelLarge: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
    ).copyWith(
      secondary: AppColors.accent,
    ),
    useMaterial3: true,
  );
}
