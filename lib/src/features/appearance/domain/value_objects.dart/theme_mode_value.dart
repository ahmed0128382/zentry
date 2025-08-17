import 'package:zentry/src/shared/enums/app_theme_mode.dart';

class ThemeModeValue {
  final AppThemeMode value;

  ThemeModeValue(this.value) {
    if (!AppThemeMode.values.contains(value)) {
      throw ArgumentError('Invalid theme mode');
    }
  }
}
