import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  AppDecorations._();

  // Splash Gradient Background
  static final BoxDecoration splashBackground = BoxDecoration(
    gradient: LinearGradient(
      colors: [AppColors.primary, AppColors.secondary],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );

  // Card Decoration with Shadow
  static final BoxDecoration card = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10,
        offset: const Offset(0, 4),
      ),
    ],
  );

  // Navigation Bar Decoration
  static final BoxDecoration navBar = BoxDecoration(
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

  // ShapeDecoration for buttons / BottomBar items
  static final ShapeDecoration navBarShape = ShapeDecoration(
    color: Colors.white,
    shadows: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.1),
        blurRadius: 12,
        offset: const Offset(0, 2),
      ),
    ],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
  );

  // Circular / Oval Decoration (Profile pictures, avatars, etc.)
  static final BoxDecoration circle = BoxDecoration(
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

  // Grey Shape Decoration (e.g., cards, containers)
  static final ShapeDecoration greyShape = ShapeDecoration(
    color: const Color(0xfff2f3f3),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  );
}
