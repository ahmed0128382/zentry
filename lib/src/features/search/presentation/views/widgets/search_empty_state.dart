import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class SearchEmptyState extends ConsumerWidget {
  const SearchEmptyState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          Text(
            'What do you want to search',
            style: TextStyle(
              color: palette.icon,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the input box to search',
            style: TextStyle(
              fontSize: 14,
              color: palette.icon.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
