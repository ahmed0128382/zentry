enum AppThemeMode { system, light, dark }

extension AppThemeModeX on AppThemeMode {
  bool get isSystem => this == AppThemeMode.system;
  bool get isLight => this == AppThemeMode.light;
  bool get isDark => this == AppThemeMode.dark;
}
