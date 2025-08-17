// lib/src/core/utils/palette.dart
import 'package:flutter/material.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';
import '../../features/appearance/domain/entities/appearance_settings.dart';

/// A small palette derived from a seed color (the user's chosen color).
/// Supports light and dark modes and provides consistent colors for text,
/// icons, backgrounds, headers, etc.
class Palette {
  final Color primary;
  final Color secondary;
  final Color accent;

  final Color background;
  final Color text;
  final Color icon;

  final Color headerBackground;
  final Color headerText;

  const Palette({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.text,
    required this.icon,
    required this.headerBackground,
    required this.headerText,
  });

  /// Create a palette from a raw ARGB int seed + brightness
  factory Palette.fromSeed(int seed,
      {Brightness brightness = Brightness.light}) {
    final primary = Color(seed);
    final hsl = HSLColor.fromColor(primary);

    final secondary = _secondaryFromHsl(hsl);
    final accent = _accentFromHsl(hsl);

    final isLight = brightness == Brightness.light;

    // Background adapts based on theme
    final background =
        isLight ? _backgroundFromPrimary(primary) : Colors.grey.shade900;

    // Text color ensures readability
    final text = isLight ? _textFromPrimary(primary) : Colors.white;

    // Icon matches text contrast but a bit toned down
    final icon = isLight ? Colors.black54 : Colors.white70;

    // Header colors slightly tinted from background
    final headerBackground =
        isLight ? Colors.grey.shade200 : Colors.grey.shade800;

    final headerText = isLight ? Colors.black87 : Colors.white70;

    return Palette(
      primary: primary,
      secondary: secondary,
      accent: accent,
      background: background,
      text: text,
      icon: icon,
      headerBackground: headerBackground,
      headerText: headerText,
    );
  }

  /// Create from an AppearanceSettings (handles null safely)
  factory Palette.fromAppearance(AppearanceSettings? settings) {
    if (settings == null) {
      return Palette.fromSeed(0xFF00B894); // fallback
    }
    return Palette.fromSeed(
      settings.seedColor,
      brightness:
          settings.themeMode.isDark ? Brightness.dark : Brightness.light,
    );
  }

  // --- helpers (adjust these formulas to taste) ---

  static Color _secondaryFromHsl(HSLColor hsl) {
    final newHue = (hsl.hue + 30) % 360; // shift hue a bit
    final newLightness = (hsl.lightness + 0.18).clamp(0.0, 1.0);
    final newSat = (hsl.saturation * 0.85).clamp(0.0, 1.0);
    return hsl
        .withHue(newHue)
        .withLightness(newLightness)
        .withSaturation(newSat)
        .toColor();
  }

  static Color _textFromPrimary(Color primary) {
    // readable text: dark if background is light, white if background is dark
    return primary.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;
  }

  static Color _backgroundFromPrimary(Color primary) {
    // very light tint of primary on white
    return Color.alphaBlend(primary.withOpacity(0.06), Colors.white);
  }

  static Color _accentFromHsl(HSLColor hsl) {
    final newLightness = (hsl.lightness * 0.8).clamp(0.0, 1.0);
    final newSat = (hsl.saturation * 1.05).clamp(0.0, 1.0);
    return hsl.withLightness(newLightness).withSaturation(newSat).toColor();
  }
}
