// File: lib/src/shared/infrastructure/repos/habits_repo_impl.dart

import 'package:drift/drift.dart' as d;
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';
import 'package:zentry/src/shared/domain/repos/habits_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

import '../../domain/entities/habit_details.dart';
import '../../domain/enums/habit_status.dart';
import '../mappers/habit_mapper.dart' as habitMapper;
import '../mappers/habit_log_mapper.dart' as habitLogMapper;
import '../mappers/habit_reminder_mapper.dart';

class HabitsRepoImpl implements HabitsRepo {
  final AppDatabase db;
  HabitsRepoImpl(this.db);

  // ---------------- CREATE ----------------
  @override
  Future<Result<Habit>> create(Habit habit) {
    return guard(() async {
      await db.insertHabit(habitMapper.habitToCompanion(habit));
      final row = await db.getHabitById(habit.id);
      if (row == null) throw Exception('Failed to fetch habit after insert');
      return habitMapper.habitFromRow(row);
    });
  }

  // ---------------- UPDATE ----------------
  @override
  Future<Result<Habit>> update(Habit habit) {
    return guard(() async {
      await (db.update(db.habitsTable)..where((t) => t.id.equals(habit.id)))
          .write(habitMapper.habitToCompanion(habit));

      final row = await db.getHabitById(habit.id);
      if (row == null) throw Exception('Failed to fetch habit after update');
      return habitMapper.habitFromRow(row);
    });
  }

  // ---------------- DELETE ----------------
  @override
  Future<Result<void>> delete(String habitId) {
    return guard(() async {
      await db.deleteHabit(habitId);
      return; // explicit void return
    });
  }

  // ---------------- GET BY ID ----------------
  @override
  Future<Result<Habit>> getById(String id) {
    return guard(() async {
      final row = await db.getHabitById(id);
      if (row == null) throw Exception('Habit not found');
      return habitMapper.habitFromRow(row);
    });
  }

  // ---------------- WATCH HABITS ----------------
  @override
  Stream<Result<List<HabitDetails>>> watchHabitsForDay({
    required DateTime day,
    String? sectionId,
  }) {
    return db.watchAllHabits().asyncMap(
          (habitRows) => guard(() async {
            final sections = await db.select(db.sectionsTable).get();
            final reminders = await db.select(db.habitRemindersTable).get();

            final logs = await (db.select(db.habitLogsTable)
                  ..where((t) => t.date
                      .equals(DateTime.utc(day.year, day.month, day.day))))
                .get();

            final sectionsMap = {for (final s in sections) s.id: s};

            final habitLogsMap = <String, List<HabitLog>>{};
            for (final log in logs) {
              habitLogsMap.putIfAbsent(log.habitId, () => []).add(
                    habitLogMapper.habitLogFromRow(log),
                  );
            }

            final details = <HabitDetails>[];
            for (final r in habitRows) {
              if (sectionId != null && r.sectionId != sectionId) continue;
              final sec = sectionsMap[r.sectionId];
              if (sec == null) continue;

              final habitLogs = habitLogsMap[r.id] ?? [];
              final completed =
                  habitLogs.any((l) => l.status == HabitStatus.completed);

              final habitRemindersList = reminders
                  .where((m) => m.habitId == r.id)
                  .map(habitReminderFromRow)
                  .toList();

              details.add(HabitDetails(
                habit: habitMapper.habitFromRow(r),
                logs: habitLogs,
                reminders: habitRemindersList,
                isCompletedForDay: completed,
              ));
            }

            return details;
          }),
        );
  }

  // ---------------- MOVE TO SECTION ----------------
  @override
  Future<Result<void>> moveToSection({
    required String habitId,
    required String newSectionId,
    required int newOrderIndex,
  }) {
    return guard(() async {
      await (db.update(db.habitsTable)..where((t) => t.id.equals(habitId)))
          .write(HabitsTableCompanion(
        sectionId: d.Value(newSectionId),
        orderInSection: d.Value(newOrderIndex),
      ));
    });
  }

  // ---------------- REORDER WITHIN SECTION ----------------
  @override
  Future<Result<void>> reorderWithinSection({
    required String sectionId,
    required List<String> orderedHabitIds,
  }) {
    return guard(() async {
      for (var i = 0; i < orderedHabitIds.length; i++) {
        final habitId = orderedHabitIds[i];
        await (db.update(db.habitsTable)..where((t) => t.id.equals(habitId)))
            .write(HabitsTableCompanion(orderInSection: d.Value(i)));
      }
    });
  }
}
