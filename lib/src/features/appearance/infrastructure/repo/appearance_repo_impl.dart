import 'package:drift/drift.dart';
import 'package:zentry/constants.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/appearance/domain/entities/appearance_settings.dart';
import 'package:zentry/src/features/appearance/domain/enums/season.dart';
import 'package:zentry/src/features/appearance/domain/repos/appearance_repo.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';

class AppearanceRepoImpl implements AppearanceRepo {
  final AppDatabase db;

  AppearanceRepoImpl(this.db);

  Season _seasonFromString(String s) {
    return Season.values.firstWhere(
      (e) => e.name == s,
      orElse: () => Season.winter,
    );
  }

  // String _seasonToString(Season s) => s.name;

  // --- Helper: map DB row → domain entity ---
  AppearanceSettings _mapToEntity(AppearanceTableData data) {
    return AppearanceSettings(
      themeMode: _mapThemeMode(data.themeMode),
      seedColor: data.seedColor,
      fontFamily: data.fontFamily,
      textScale: data.textScale,
      season: _seasonFromString(data.season),
    );
  }

  // --- Helper: map themeMode string <-> enum ---
  static AppThemeMode _mapThemeMode(String mode) {
    switch (mode) {
      case "light":
        return AppThemeMode.light;
      case "dark":
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }

  static String _themeModeToString(AppThemeMode mode) {
    switch (mode) {
      case AppThemeMode.light:
        return "light";
      case AppThemeMode.dark:
        return "dark";
      case AppThemeMode.system:
      default:
        return "system";
    }
  }

  @override
  Future<AppearanceSettings> loadAppearanceSettings() async {
    final data = await db.getAppearanceSettings();
    return data == null
        ? const AppearanceSettings(
            themeMode: AppThemeMode.system,
            seedColor: 0xFF00FF00, // maybe your app’s primary
            fontFamily: "Cairo",
            textScale: 1.0, season: Season.winter, // default values
          )
        : _mapToEntity(data);
  }

  @override
  Stream<AppearanceSettings?> watchAppearanceSettings() {
    return db.select(db.appearanceTable).watchSingleOrNull().map((data) {
      if (data == null) return null;
      return AppearanceSettings(
        themeMode: AppThemeMode.values.firstWhere(
          (mode) => mode.name == data.themeMode,
          orElse: () => AppThemeMode.system,
        ),
        seedColor: data.seedColor,
        fontFamily: data.fontFamily,
        textScale: data.textScale,
        season: Season.winter,
      );
    });
  }

  @override
  Future<void> updateAppearanceSettings(AppearanceSettings settings) async {
    await db.into(db.appearanceTable).insertOnConflictUpdate(
          AppearanceTableCompanion(
            id: const Value(kRowAppearanceId), // always one row
            themeMode: Value(settings.themeMode.name),
            seedColor: Value(settings.seedColor),
            fontFamily: Value(settings.fontFamily),
            textScale: Value(settings.textScale),
          ),
        );
  }
}
