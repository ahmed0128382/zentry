import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/utils/palette.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class ReminderPopup extends ConsumerWidget {
  final Reminder reminder;
  final VoidCallback? onMarkDone;
  final VoidCallback? onSnooze;

  const ReminderPopup({
    super.key,
    required this.reminder,
    this.onMarkDone,
    this.onSnooze,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Palette palette = ref.watch(appPaletteProvider);

    return AlertDialog(
      backgroundColor: palette.background,
      title: Text(
        reminder.title ?? 'Reminder',
        style: TextStyle(color: palette.text, fontWeight: FontWeight.bold),
      ),
      content: Text(
        reminder.body ?? 'It\'s time!',
        style: TextStyle(color: palette.text),
      ),
      actions: [
        if (onSnooze != null)
          TextButton(
            onPressed: onSnooze,
            child: const Text('Snooze'),
          ),
        if (onMarkDone != null)
          TextButton(
            onPressed: onMarkDone,
            child: const Text('Done'),
          ),
      ],
    );
  }
}
