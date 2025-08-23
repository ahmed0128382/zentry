// File: src/features/habits/infrastructure/repositories/habit_reminders_repo_impl.dart

import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_reminders_repo.dart';
import 'package:zentry/src/features/habits/infrastructure/mappers/habit_reminder_mapper.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class HabitRemindersRepoImpl implements HabitRemindersRepo {
  final AppDatabase _db;

  HabitRemindersRepoImpl(this._db);

  @override
  Future<Result<List<HabitReminder>>> getForHabit(String habitId) {
    return guard(() async {
      final rows = await _db.getRemindersForHabit(habitId);
      return rows.map(habitReminderFromRow).toList();
    });
  }

  @override
  Future<Result<HabitReminder>> add(HabitReminder reminder) {
    return guard(() async {
      final row = await _db.insertReminder(habitReminderToCompanion(reminder));
      return habitReminderFromRow(row);
    });
  }

  @override
  Future<Result<HabitReminder>> update(HabitReminder reminder) {
    return guard(() async {
      final row = await _db.updateReminder(habitReminderToCompanion(reminder));
      if (row == null) throw Exception('Reminder not found');
      return habitReminderFromRow(row);
    });
  }

  @override
  Future<Result<void>> delete(String reminderId) {
    return guard(() async {
      await _db.deleteReminder(reminderId);
      return;
    });
  }
}
