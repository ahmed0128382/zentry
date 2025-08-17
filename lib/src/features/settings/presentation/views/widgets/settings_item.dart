import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class SettingsItem extends ConsumerWidget {
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? color;
  final Widget? trailing;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return InkWell(
      // focusColor: palette.primary.withValues(alpha: 0.2),
      // hoverColor: palette.primary.withValues(alpha: 0.1),
      // splashColor: palette.primary.withValues(alpha: 0.2),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: (color ?? palette.secondary.withValues(alpha: 0.8))
                    .withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon,
                  color: color ?? palette.primary.withValues(alpha: 0.8),
                  size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            trailing ??
                const Icon(Icons.arrow_forward_ios,
                    color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
