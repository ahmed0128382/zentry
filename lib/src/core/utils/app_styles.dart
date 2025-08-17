import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {
  AppStyles._();

  // Text Styles

  // Small
  static final TextStyle semiBold11 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.semiBold,
    fontSize: 11,
    color: AppColors.text,
  );

  static final TextStyle regular11 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.regular,
    fontSize: 11,
    color: AppColors.text,
  );

  // Medium
  static final TextStyle regular13 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.regular,
    fontSize: 13,
    color: AppColors.text,
  );

  static final TextStyle semiBold13 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.semiBold,
    fontSize: 13,
    color: AppColors.text,
  );

  static final TextStyle bold13 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.bold,
    fontSize: 13,
    color: AppColors.text,
  );

  // Larger
  static final TextStyle regular16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.regular,
    fontSize: 16,
    color: AppColors.text,
  );

  static final TextStyle semiBold16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.semiBold,
    fontSize: 16,
    color: AppColors.text,
  );

  static final TextStyle bold16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.bold,
    fontSize: 16,
    color: AppColors.text,
  );

  static final TextStyle semiBold19 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.semiBold,
    fontSize: 19,
    color: AppColors.text,
  );

  static final TextStyle bold19 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.bold,
    fontSize: 19,
    color: AppColors.text,
  );

  static final TextStyle regular26 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.regular,
    fontSize: 26,
    color: AppColors.text,
  );

  static final TextStyle bold23 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: AppFontWeights.bold,
    fontSize: 23,
    color: AppColors.text,
  );

  // Headings
  static final TextStyle heading1 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 32,
    fontWeight: AppFontWeights.bold,
    color: AppColors.text,
  );

  static final TextStyle heading2 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 24,
    fontWeight: AppFontWeights.semiBold,
    color: AppColors.text,
  );

  // Body & subtitle
  static final TextStyle body = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 16,
    fontWeight: AppFontWeights.regular,
    color: AppColors.text,
  );

  static final TextStyle subtitle = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontSize: 14,
    fontWeight: AppFontWeights.regular,
    color: AppColors.secondary,
  );

  // Splash-specific
  static const TextStyle splashTagline = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Colors.white70,
    letterSpacing: 1.2,
    fontFamily: 'Inter',
  );
}
