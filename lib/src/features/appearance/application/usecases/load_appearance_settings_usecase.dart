import 'package:zentry/src/features/appearance/domain/repos/appearance_repo.dart';

import '../../domain/entities/appearance_settings.dart';

class LoadAppearanceSettingsUseCase {
  final AppearanceRepo repository;

  LoadAppearanceSettingsUseCase(this.repository);

  Future<AppearanceSettings?> call() async {
    return await repository.loadAppearanceSettings();
  }
}
