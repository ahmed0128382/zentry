// File: src/core/reminders/application/reminders_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/schedule_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/cancel_reminder.dart';
import 'package:zentry/src/core/reminders/domain/usecases/get_reminders_for_habit.dart';
import 'package:zentry/src/core/reminders/application/states/reminders_state.dart';

class RemindersController extends StateNotifier<RemindersState> {
  final ScheduleReminder _scheduleReminder;
  final CancelReminder _cancelReminder;
  final GetRemindersForHabit _getRemindersForHabit;

  RemindersController(
    this._scheduleReminder,
    this._cancelReminder,
    this._getRemindersForHabit,
  ) : super(RemindersInitial());

  Future<void> loadReminders(String habitId) async {
    state = RemindersLoading();

    final result = await _getRemindersForHabit(habitId);

    result.fold(
      (failure) => state = RemindersError(failure.message),
      (List<Reminder> reminders) => state = RemindersLoaded(reminders),
    );
  }

  Future<void> addReminder(Reminder reminder) async {
    final result = await _scheduleReminder(reminder);

    result.fold(
      (failure) {
        state = RemindersError(failure.message);
      },
      (_) async {
        // Refresh reminders after successfully adding
        await loadReminders(reminder.ownerId);
      },
    );
  }

  Future<void> removeReminder(String reminderId, String habitId) async {
    final result = await _cancelReminder(reminderId);

    result.fold(
      (failure) {
        state = RemindersError(failure.message);
      },
      (_) async {
        // Refresh reminders after successfully removing
        await loadReminders(habitId);
      },
    );
  }
}
