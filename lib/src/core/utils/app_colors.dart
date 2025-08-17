import 'package:flutter/material.dart';
import '../../features/appearance/domain/entities/appearance_settings.dart';

class AppColors {
  AppColors._(); // private constructor

  // Default colors (fallbacks)
  static Color lightBackground = const Color(0xFFFDFDFD);
  static Color lightText = const Color(0xFF111111);
  static Color darkBackground = const Color(0xFF121212);
  static Color darkText = const Color(0xFFECECEC);

  static Color primary = const Color(0xFF00B894); // أخضر زمردي هادئ
  static Color secondary = const Color(0xFF0984E3); // أزرق فاتح
  static Color background = const Color(0xFFF1F2F6); // رمادي فاتح عصري
  static Color text = const Color(0xFF2D3436); // رمادي غامق للنصوص
  static Color accent = const Color(0xFFFFC312); // أصفر مشرق للنقاط المهمة
  static Color error = const Color(0xFFEB4D4B); // أحمر للأخطاء
  static Color peacefulSeaBlue = const Color(0xFF00B4D8);

  /// Call this whenever AppearanceSettings changes
  static void updateFromAppearance(AppearanceSettings? appearance) {
    // Only seedColor can affect colors for now
    final seedColor =
        appearance?.seedColor ?? primary.toARGB32(); // fallback emerald green

    primary = Color(seedColor);

    // Optionally, you can compute shades of the seedColor for other fields:
    background = primary.withValues(alpha: 0.05);
    text = primary.withValues(alpha: 0.9);
    secondary = primary.withValues(alpha: 0.6);
    accent = primary.withValues(alpha: 0.8);
  }
}
