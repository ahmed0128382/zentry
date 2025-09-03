import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/utils/palette.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class ReminderCard extends ConsumerWidget {
  final Reminder reminder;
  final VoidCallback? onMarkDone;
  final VoidCallback? onSnooze;
  final VoidCallback? onCancel;

  const ReminderCard({
    super.key,
    required this.reminder,
    this.onMarkDone,
    this.onSnooze,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Palette palette = ref.watch(appPaletteProvider);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      color: palette.background,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Reminder info
            Row(
              children: [
                Icon(Icons.notifications, color: palette.icon),
                const SizedBox(width: 8),
                Text(
                  '${reminder.hour.toString().padLeft(2, '0')}:${reminder.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(color: palette.text),
                ),
                if (reminder.title != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    reminder.title!,
                    style: TextStyle(color: palette.text),
                  ),
                ]
              ],
            ),

            // Actions
            Row(
              children: [
                if (onMarkDone != null)
                  IconButton(
                    icon: Icon(Icons.check, color: Colors.green.shade700),
                    onPressed: onMarkDone,
                  ),
                if (onSnooze != null)
                  IconButton(
                    icon: Icon(Icons.snooze, color: Colors.orange.shade700),
                    onPressed: onSnooze,
                  ),
                if (onCancel != null)
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.red.shade700),
                    onPressed: onCancel,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
