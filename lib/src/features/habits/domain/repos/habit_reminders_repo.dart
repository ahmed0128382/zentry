// File: src/features/habits/domain/repos/habit_reminders_repo.dart

import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

import '../entities/habit_reminder.dart';

abstract class HabitRemindersRepo {
  Future<Result<List<HabitReminder>>> getForHabit(String habitId);
  Future<Result<HabitReminder>> add(HabitReminder reminder);
  Future<Result<HabitReminder>> update(HabitReminder reminder);
  Future<Result<void>> delete(String reminderId);
}
