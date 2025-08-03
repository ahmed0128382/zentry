import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {
  static const TextStyle heading1 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.text,
  );
  static const TextStyle splashTagline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    letterSpacing: 1.2,
    fontFamily: 'Inter',
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  static const TextStyle body = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.text,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 14,
    color: AppColors.secondary,
  );
}
