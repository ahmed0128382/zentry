import '../entities/appearance_settings.dart';

abstract class AppearanceRepo {
  Future<AppearanceSettings?> loadAppearanceSettings();
  Stream<AppearanceSettings?> watchAppearanceSettings();
  Future<void> updateAppearanceSettings(AppearanceSettings settings);
}
