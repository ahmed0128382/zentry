// lib/src/core/application/providers/app_palette_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/palette.dart';
import 'package:zentry/src/features/appearance/application/providers/appearance_controller_provider.dart';

final appPaletteProvider = Provider<Palette>((ref) {
  final appearance = ref.watch(appearanceControllerProvider);
  return Palette.fromAppearance(appearance);
});
