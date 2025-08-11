import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  // ✅ Splash Gradient Background
  static const BoxDecoration splashBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primary, AppColors.secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // ✅ Card with Shadow
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );

  // ✅ Navigation Bar Decoration
  static final BoxDecoration navBarBox = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.2),
        blurRadius: 20,
        offset: const Offset(0, -2),
      ),
    ],
  );

  // ✅ ShapeDecoration (مثلاً لأزرار أو BottomBar items)
  static final ShapeDecoration navBarShapeDecoration = ShapeDecoration(
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.1),
        blurRadius: 12,
        offset: const Offset(0, 2),
      ),
    ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // ✅ Circle / Oval Decoration (مثلاً للبروفايل أو أي عنصر دائري)
  static final BoxDecoration circleDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: AppColors.primary.withValues(alpha: 0.1),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withValues(alpha: 0.2),
        blurRadius: 8,
        offset: const Offset(0, 3),
      ),
    ],
  );
  static var greyShapeDecoration = ShapeDecoration(
      color: Color(0x7ff2f3f3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ));
}
