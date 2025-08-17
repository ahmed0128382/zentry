import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/appearance/application/controllers/appearance_controller.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_repo_provider.dart';
import 'package:zentry/src/features/appearance/domain/entities/appearance_settings.dart';

final appearanceControllerProvider =
    StateNotifierProvider<AppearanceController, AppearanceSettings?>((ref) {
  final repo = ref.watch(appearanceRepoProvider);
  return AppearanceController(repo);
});
