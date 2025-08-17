import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/core/widgets/custom_card.dart';

class SettingsPremiumAccountSection extends ConsumerWidget {
  const SettingsPremiumAccountSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return CustomCard(
      child: Row(
        children: [
          Icon(Icons.workspace_premium,
              color: palette.primary.withValues(alpha: 0.8), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Premium Account',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: palette.icon.withValues(alpha: 0.8))),
                const SizedBox(height: 4),
                Text('Calendar view and more fun...',
                    style: TextStyle(color: palette.icon, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              foregroundColor: palette.primary,
              backgroundColor: palette.secondary.withValues(alpha: 0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: palette.primary.withValues(alpha: 0.5),
                ),
              ),
              elevation: 0,
            ),
            child: const Text('UPGRADE NOW'),
          ),
        ],
      ),
    );
  }
}
