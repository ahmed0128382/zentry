// File: src/core/reminders/application/providers/reminder_controller_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/application/controllers/reminders_controller.dart';
import 'package:zentry/src/core/reminders/application/providers/cancel_reminder_provider.dart';
import 'package:zentry/src/core/reminders/application/providers/get_reminders_for_habit_provider.dart';
import 'package:zentry/src/core/reminders/application/providers/schedule_reminder_provider.dart';

import 'package:zentry/src/core/reminders/application/states/reminders_state.dart';

final remindersControllerProvider =
    StateNotifierProvider<RemindersController, RemindersState>((ref) {
  return RemindersController(
    ref.watch(scheduleReminderProvider),
    ref.watch(cancelReminderProvider),
    ref.watch(getRemindersForHabitProvider),
  );
});
