import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_fonts.dart';

class AppStyles {
  static const TextStyle bold13 = TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontWeight: FontWeight.bold,
      fontSize: 13,
      color: Color(0xff0c0d0d));
  static const TextStyle bold23 = TextStyle(
      fontFamily: AppFonts.primaryFont,
      fontWeight: FontWeight.bold,
      fontSize: 23,
      color: Color(0xff0c0d0d));
  static const TextStyle semiBold13 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular13 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 13,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle bold16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle semiBold16 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular23 = TextStyle(
    fontFamily: 'SF Pro Text',
    fontWeight: FontWeight.normal,
    fontSize: 23,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular22 = TextStyle(
    fontFamily: 'SF Pro Display',
    fontWeight: FontWeight.normal,
    fontSize: 23,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle bold19 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.bold,
    fontSize: 19,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle semiBold11 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle semiBold19 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 19,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular11 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.w600,
    fontSize: 11,
    color: Color(0xff0c0d0d),
  );
  static const TextStyle regular26 = TextStyle(
    fontFamily: AppFonts.primaryFont,
    fontWeight: FontWeight.normal,
    fontSize: 26,
    color: Color(0xff0c0d0d),
  );

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
