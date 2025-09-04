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
        style: TextStyle(color: palette.icon, fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (reminder.body != null)
            Text(
              reminder.body!,
              style: TextStyle(color: palette.icon),
            ),
          const SizedBox(height: 8),
          Text(
            '⏰ ${reminder.time.toString()}', // ✅ "HH:mm"
            style:
                TextStyle(color: palette.icon.withOpacity(0.7), fontSize: 12),
          ),
          if (reminder.weekdays.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Repeats on: ${_formatWeekdays(reminder.weekdays)}',
              style:
                  TextStyle(color: palette.icon.withOpacity(0.7), fontSize: 12),
            ),
          ],
        ],
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

String _formatWeekdays(List<int> days) {
  const names = {
    DateTime.monday: 'Mon',
    DateTime.tuesday: 'Tue',
    DateTime.wednesday: 'Wed',
    DateTime.thursday: 'Thu',
    DateTime.friday: 'Fri',
    DateTime.saturday: 'Sat',
    DateTime.sunday: 'Sun',
  };
  return days.map((d) => names[d] ?? d.toString()).join(', ');
}
