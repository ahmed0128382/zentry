// File: src/core/reminders/application/providers/reminder_controller_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/application/controllers/reminders_controller.dart';
import 'package:zentry/src/core/reminders/application/providers/reminder_repo_provider.dart';
import 'package:zentry/src/core/reminders/domain/usecases/cancel_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/get_reminders_for_habit.dart';
import 'package:zentry/src/core/reminders/domain/usecases/schedule_reminder.dart';
import 'package:zentry/src/core/reminders/application/states/reminders_state.dart';

final remindersControllerProvider =
    StateNotifierProvider<RemindersController, RemindersState>((ref) {
  final repo = ref.watch(reminderRepoProvider);

  return RemindersController(
    ScheduleReminder(repo),
    CancelReminder(repo),
    GetRemindersForHabit(repo),
  );
});
