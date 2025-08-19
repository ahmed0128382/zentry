import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class SearchHeader extends ConsumerWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Text(
      'Search',
      style: TextStyle(
        color: palette.icon,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
