import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/application/controllers/reminders_controller.dart';
import 'package:zentry/src/core/reminders/application/providers/reminder_repo_provider.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/cancel_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/get_reminders_for_habit.dart';
import 'package:zentry/src/core/reminders/domain/usecases/schedule_reminder.dart';

final remindersControllerProvider =
    StateNotifierProvider<RemindersController, AsyncValue<List<Reminder>>>(
        (ref) {
  final repo = ref.watch(reminderRepoProvider);
  return RemindersController(
    ScheduleReminder(repo),
    CancelReminder(repo),
    GetRemindersForHabit(repo),
  );
});
