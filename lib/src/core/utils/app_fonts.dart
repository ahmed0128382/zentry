import 'package:flutter/material.dart';
import '../../features/appearance/domain/entities/appearance_settings.dart';

class AppFonts {
  AppFonts._();

  static String primaryFont = 'Cairo';

  /// Call this whenever AppearanceSettings changes
  static void updateFromAppearance(AppearanceSettings appearance) {
    primaryFont = appearance.fontFamily;
  }

  static TextStyle getPrimaryStyle({
    required AppearanceSettings appearance,
    double size = 14,
    FontWeight weight = FontWeight.w400,
  }) {
    return TextStyle(
      fontFamily: appearance.fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: Color(appearance.seedColor),
    );
  }
}

class AppFontWeights {
  AppFontWeights._();
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
}
