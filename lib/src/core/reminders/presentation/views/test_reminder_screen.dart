// // File: lib/src/core/reminders/presentation/pages/reminder_test_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
// import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
// import 'package:zentry/src/core/reminders/application/providers/notification_service_provider.dart';
// import 'package:zentry/src/core/reminders/presentation/widgets/reminder_card.dart';
// import 'package:zentry/src/core/reminders/presentation/widgets/reminder_popup.dart';
// import 'package:timezone/timezone.dart' as tz;

// class ReminderTestPage extends ConsumerStatefulWidget {
//   const ReminderTestPage({super.key});
//   static const routeName = '/test-reminder-screen';

//   @override
//   ConsumerState<ReminderTestPage> createState() => _ReminderTestPageState();
// }

// class _ReminderTestPageState extends ConsumerState<ReminderTestPage> {
//   Reminder? _lastReminder;

//   /// Schedule a reminder 10 seconds from now using the Reminder entity
//   Future<void> _scheduleQuickReminder() async {
//     final service = ref.read(notificationServiceProvider);

//     final now = tz.TZDateTime.now(tz.local);
//     final scheduledTime = now.add(const Duration(seconds: 10));

//     final reminder = Reminder(
//       id: "scheduled10s",
//       ownerId: "habit123",
//       ownerType: "habit",
//       time: ReminderTime.fromHMS(
//         scheduledTime.hour,
//         scheduledTime.minute,
//         scheduledTime.second,
//       ),
//       title: "Scheduled Reminder (10s)",
//       body: "This reminder will appear in 10 seconds ⏰",
//     );

//     // Schedule using Reminder entity directly
//     await service.scheduleNotification(reminder);

//     if (mounted) {
//       setState(() => _lastReminder = reminder);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Reminder scheduled for 10 seconds ✅")),
//       );
//     }
//   }

//   /// Show notification immediately using Reminder entity
//   Future<void> _showImmediateReminder() async {
//     final service = ref.read(notificationServiceProvider);

//     final now = DateTime.now();
//     final reminder = Reminder(
//       id: "quick1",
//       ownerId: "habit123",
//       ownerType: "habit",
//       time: ReminderTime.fromHMS(now.hour, now.minute),
//       title: "Quick Reminder",
//       body: "This is a test ⏰",
//     );

//     await service.showNotification(reminder);

//     if (mounted) setState(() => _lastReminder = reminder);

//     // Show popup immediately
//     showDialog(
//       context: context,
//       builder: (_) => ReminderPopup(
//         reminder: reminder,
//         onMarkDone: () async {
//           await service.cancelNotification(reminder);
//           if (mounted) Navigator.of(context).pop();
//         },
//         onSnooze: () {
//           Navigator.of(context).pop();
//         },
//       ),
//     );

//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Notification shown ✅")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Reminder Playground")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _showImmediateReminder,
//               child: const Text("Show Notification Now"),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _scheduleQuickReminder,
//               child: const Text("Schedule Reminder (10s)"),
//             ),
//             if (_lastReminder != null) ...[
//               const SizedBox(height: 30),
//               Text(
//                 "Last Reminder: ${_lastReminder!.title}",
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ReminderCard(reminder: _lastReminder!),
//             ],
//           ],
//         ),
//       ),
//     );
//   }
// }
// File: lib/src/core/reminders/presentation/pages/reminder_test_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/value_objects/reminder_time.dart';
import 'package:zentry/src/core/reminders/application/providers/notification_service_provider.dart';
import 'package:zentry/src/core/reminders/presentation/widgets/reminder_card.dart';
import 'package:zentry/src/core/reminders/presentation/widgets/reminder_popup.dart';
import 'package:timezone/timezone.dart' as tz;

class ReminderTestPage extends ConsumerStatefulWidget {
  const ReminderTestPage({super.key});
  static const routeName = '/test-reminder-screen';

  @override
  ConsumerState<ReminderTestPage> createState() => _ReminderTestPageState();
}

class _ReminderTestPageState extends ConsumerState<ReminderTestPage> {
  Reminder? _lastReminder;

  /// Schedule a reminder 10 seconds from now using the Reminder entity
  Future<void> _scheduleQuickReminder() async {
    final service = ref.read(notificationServiceProvider);

    // Schedule 10 seconds from now
    final scheduledTime = DateTime.now().add(const Duration(seconds: 10));

    // Create Reminder entity
    final reminder = Reminder(
      id: "scheduled10s",
      ownerId: "habit123",
      ownerType: "habit",
      time: ReminderTime.fromDateTime(scheduledTime),
      title: "Scheduled Reminder (10s)",
      body: "This reminder will appear in 10 seconds ⏰",
    );

    // Schedule notification using Reminder entity
    await service.scheduleNotification(reminder);

    if (mounted) {
      setState(() => _lastReminder = reminder);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Reminder scheduled for 10 seconds ✅")),
      );
    }
  }

  /// Show notification immediately using Reminder entity
  Future<void> _showImmediateReminder() async {
    final service = ref.read(notificationServiceProvider);

    final now = DateTime.now();
    final reminder = Reminder(
      id: "quick1",
      ownerId: "habit123",
      ownerType: "habit",
      time: ReminderTime.fromDateTime(now),
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
              child: const Text("Schedule Reminder (10s)"),
            ),
            if (_lastReminder != null) ...[
              const SizedBox(height: 30),
              Text(
                "Last Reminder: ${_lastReminder!.title}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              ReminderCard(reminder: _lastReminder!),
            ],
          ],
        ),
      ),
    );
  }
}
