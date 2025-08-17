import '../features/appearance/domain/entities/appearance_settings.dart'; // adjust path if needed

class AppearanceManager {
  AppearanceManager._();
  static final AppearanceManager instance = AppearanceManager._();

  AppearanceSettings? _settings;

  void update(AppearanceSettings settings) {
    _settings = settings;
  }

  AppearanceSettings get state {
    if (_settings == null) {
      throw Exception("AppearanceState not initialized yet");
    }
    return _settings!;
  }
}
