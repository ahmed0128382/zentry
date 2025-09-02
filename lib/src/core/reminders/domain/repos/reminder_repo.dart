// File: lib/src/core/reminders/domain/repositories/reminder_repository.dart

import 'package:zentry/src/core/reminders/domain/entities/reminder.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

abstract class ReminderRepo {
  /// Schedule a reminder (store + schedule notification)
  Future<Result<void>> scheduleReminder(Reminder reminder);

  /// Cancel a specific reminder
  Future<Result<void>> cancelReminder(String reminderId);

  /// Get all reminders
  Future<Result<List<Reminder>>> getAllReminders();

  /// Get reminders related to a specific habit
  Future<Result<List<Reminder>>> getRemindersForHabit(String habitId);
}
