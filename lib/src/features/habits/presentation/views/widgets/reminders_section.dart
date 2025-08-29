import 'package:flutter/material.dart';

class RemindersSection extends StatelessWidget {
  final List<TimeOfDay> reminders;
  final Function(TimeOfDay) onPickReminder;
  final Function(TimeOfDay) onRemoveReminder;

  const RemindersSection({
    super.key,
    required this.reminders,
    required this.onPickReminder,
    required this.onRemoveReminder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Reminders',
                style: TextStyle(fontWeight: FontWeight.bold)),
            IconButton(
              icon: const Icon(Icons.add_alarm),
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) onPickReminder(picked);
              },
            ),
          ],
        ),
        Wrap(
          spacing: 8,
          children: reminders
              .map((time) => Chip(
                    label: Text(time.format(context)),
                    onDeleted: () => onRemoveReminder(time),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
