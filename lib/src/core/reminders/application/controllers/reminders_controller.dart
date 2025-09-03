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

  /// Load all reminders for a given habit
  Future<void> loadReminders(String habitId) async {
    state = RemindersLoading();

    final result = await _getRemindersForHabit(habitId);

    result.fold(
      (failure) => state = RemindersError(failure.message),
      (List<Reminder> reminders) => state = RemindersLoaded(reminders),
    );
  }

  /// Add a new reminder
  Future<void> addReminder(Reminder reminder,
      {bool repeatWeekly = false}) async {
    final result =
        await _scheduleReminder(reminder, repeatWeekly: repeatWeekly);

    result.fold(
      (failure) => state = RemindersError(failure.message),
      (_) async => await loadReminders(reminder.ownerId),
    );
  }

  /// Remove a reminder
  Future<void> removeReminder(Reminder reminder) async {
    final result = await _cancelReminder(reminder);

    result.fold(
      (failure) => state = RemindersError(failure.message),
      (_) async => await loadReminders(reminder.ownerId),
    );
  }
}
