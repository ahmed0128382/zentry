import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/appearance/domain/entities/appearance_settings.dart';
import 'package:zentry/src/features/appearance/domain/enums/season.dart';
import 'package:zentry/src/features/appearance/domain/repos/appearance_repo.dart';
import 'package:zentry/src/shared/enums/app_theme_mode.dart';

class AppearanceController extends StateNotifier<AppearanceSettings?> {
  final AppearanceRepo repo;

  AppearanceController(this.repo) : super(null) {
    _load();
  }

  Future<void> _load() async {
    state = await repo.loadAppearanceSettings();
  }

  Future<void> updateTheme(AppThemeMode mode) async {
    final newSettings = state!.copyWith(themeMode: mode);
    await repo.updateAppearanceSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateSeedColor(int color) async {
    final newSettings = state!.copyWith(seedColor: color);
    await repo.updateAppearanceSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateFont(String font) async {
    final newSettings = state!.copyWith(fontFamily: font);
    await repo.updateAppearanceSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateTextScale(double scale) async {
    final newSettings = state!.copyWith(textScale: scale);
    await repo.updateAppearanceSettings(newSettings);
    state = newSettings;
  }

  Future<void> updateSeason(Season season) async {
    final newSettings = state!.copyWith(season: season);
    await repo.updateAppearanceSettings(newSettings);
    state = newSettings;
  }
}
