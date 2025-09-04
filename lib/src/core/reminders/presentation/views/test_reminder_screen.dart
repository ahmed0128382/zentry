import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
import 'package:zentry/src/core/reminders/application/providers/notification_service_provider.dart';
import 'package:zentry/src/core/reminders/presentation/widgets/reminder_card.dart';
import 'package:zentry/src/core/reminders/presentation/widgets/reminder_popup.dart';

class ReminderTestPage extends ConsumerStatefulWidget {
  const ReminderTestPage({super.key});
  static const routeName = '/test-reminder-screen';

  @override
  ConsumerState<ReminderTestPage> createState() => _ReminderTestPageState();
}

class _ReminderTestPageState extends ConsumerState<ReminderTestPage> {
  Reminder? _lastReminder;

  Future<void> _scheduleQuickReminder() async {
    final service = ref.read(notificationServiceProvider);

    final reminder = Reminder(
      id: "scheduled1",
      ownerId: "habit123",
      ownerType: "habit",
      time: ReminderTime.fromHMS(
        DateTime.now().hour,
        DateTime.now().minute,
      ),
      title: "Scheduled Reminder",
      body: "This reminder will appear in 1 minute ⏰",
    );

    await service.scheduleNotification(
      id: 2,
      title: reminder.title ?? "REMINDER",
      body: reminder.body ?? "",
      hour: reminder.time.hour,
      minute: reminder.time.minute,
    );

    if (mounted) {
      setState(() => _lastReminder = reminder);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reminder scheduled for 1 minute ✅")),
      );
    }
  }

  Future<void> _showImmediateReminder() async {
    final service = ref.read(notificationServiceProvider);

    final reminder = Reminder(
      id: "quick1",
      ownerId: "habit123",
      ownerType: "habit",
      time: ReminderTime.fromHMS(DateTime.now().hour, DateTime.now().minute),
      title: "Quick Reminder",
      body: "This is a test ⏰",
    );

    await service.showNotification(reminder);

    if (mounted) setState(() => _lastReminder = reminder);

    // Show popup immediately
    showDialog(
      context: context,
      builder: (_) => ReminderPopup(
        reminder: reminder,
        onMarkDone: () async {
          await service.cancelNotification(reminder);
          if (mounted) Navigator.of(context).pop();
        },
        onSnooze: () {
          Navigator.of(context).pop();
        },
      ),
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Notification shown ✅")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final service = ref.read(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Reminder Playground")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _showImmediateReminder,
              child: const Text("Show Notification Now"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _scheduleQuickReminder,
              child: const Text("Schedule Reminder (1 min)"),
            ),
          ],
        ),
      ),
    );
  }
}
