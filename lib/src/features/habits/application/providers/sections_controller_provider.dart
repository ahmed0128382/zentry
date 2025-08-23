// Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/sections_controller.dart';
import 'package:zentry/src/features/habits/application/providers/sections_repo_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';

final sectionsControllerProvider =
    StateNotifierProvider<SectionsController, AsyncValue<List<Section>>>((ref) {
  return SectionsController(ref.read(sectionsRepoProvider));
});
