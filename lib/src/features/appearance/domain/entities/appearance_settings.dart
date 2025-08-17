import 'package:zentry/src/features/appearance/domain/enums/season.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';

class AppearanceSettings {
  final AppThemeMode themeMode; // 'system', 'light', 'dark'
  final int seedColor; // store as ARGB int
  final String fontFamily;
  final double textScale;
  final Season season;

  const AppearanceSettings({
    required this.season,
    required this.themeMode,
    required this.seedColor,
    required this.fontFamily,
    required this.textScale,
  });

  /// Creates a copy with updated fields
  AppearanceSettings copyWith({
    AppThemeMode? themeMode,
    int? seedColor,
    String? fontFamily,
    double? textScale,
    Season? season,
  }) {
    return AppearanceSettings(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
      fontFamily: fontFamily ?? this.fontFamily,
      textScale: textScale ?? this.textScale,
      season: season ?? this.season,
    );
  }

  /// Convert to a map (useful for Drift, JSON, etc.)
  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode.name,
      'seedColor': seedColor,
      'fontFamily': fontFamily,
      'textScale': textScale,
    };
  }

  /// Create from a map
  factory AppearanceSettings.fromMap(Map<String, dynamic> map) {
    return AppearanceSettings(
      themeMode: AppThemeMode.values.firstWhere(
          (e) => e.name == map['themeMode'],
          orElse: () => AppThemeMode.system),
      seedColor: map['seedColor'] as int,
      fontFamily: map['fontFamily'] as String,
      textScale: (map['textScale'] as num).toDouble(),
      season: Season.values.firstWhere((e) => e.name == map['season'],
          orElse: () => Season.spring), // default to spring if not found
    );
  }
}
