// File: src/core/reminders/application/reminders_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/schedule_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/cancel_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/get_reminders_for_habit.dart';
import 'package:zentry/src/shared/domain/errors/failure.dart';

class RemindersController extends StateNotifier<AsyncValue<List<Reminder>>> {
  final ScheduleReminder _scheduleReminder;
  final CancelReminder _cancelReminder;
  final GetRemindersForHabit _getRemindersForHabit;

  RemindersController(
    this._scheduleReminder,
    this._cancelReminder,
    this._getRemindersForHabit,
  ) : super(const AsyncValue.loading());

  Future<void> loadReminders(String habitId) async {
    state = const AsyncValue.loading();
    final result = await _getRemindersForHabit(habitId);

    result.fold(
      (Failure failure) {
        state =
            AsyncValue.error(failure, failure.stackTrace ?? StackTrace.current);
      },
      (List<Reminder> reminders) {
        state = AsyncValue.data(reminders);
      },
    );
  }

  Future<void> addReminder(Reminder reminder) async {
    final result = await _scheduleReminder(reminder);

    result.fold(
      (_) {
        // failure: do nothing (or log/show snackbar)
      },
      (_) async {
        await loadReminders(reminder.ownerId); // refresh list
      },
    );
  }

  Future<void> removeReminder(String reminderId, String habitId) async {
    final result = await _cancelReminder(reminderId);

    result.fold(
      (_) {
        // failure: do nothing
      },
      (_) async {
        await loadReminders(habitId); // refresh list
      },
    );
  }
}
