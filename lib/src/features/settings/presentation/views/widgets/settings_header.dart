import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class SettingsHeader extends ConsumerWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 16.0),
      child: Text(
        'Settings',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: palette.icon,
        ),
      ),
    );
  }
}
