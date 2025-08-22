// File: src/features/habits/infrastructure/mappers/habit_reminder_mapper.dart

import 'package:drift/drift.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';

// --- HabitReminder ---

HabitReminder habitReminderFromRow(HabitRemindersTableData row) {
  return HabitReminder(
    id: row.id,
    habitId: row.habitId,
    minutesSinceMidnight: row.minutesSinceMidnight,
    enabled: row.enabled,
  );
}

HabitRemindersTableCompanion habitReminderToCompanion(HabitReminder reminder) {
  return HabitRemindersTableCompanion(
    id: Value(reminder.id),
    habitId: Value(reminder.habitId),
    minutesSinceMidnight: Value(reminder.minutesSinceMidnight),
    enabled: Value(reminder.enabled),
  );
}
