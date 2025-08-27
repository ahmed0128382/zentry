import 'dart:developer';
import 'package:drift/drift.dart' as d;

// ✅ fixed path
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';

import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/entities/section_with_habits.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
import 'package:zentry/src/features/habits/infrastructure/mappers/habit_section_mapper.dart';
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
      log('Created habit Row In HabitRepoImpl: $row');
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
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);

    return db.watchAllHabits().asyncMap((habitRows) async {
      return await guard(() async {
        // we still read reminders & logs
        final reminders = await db.select(db.habitRemindersTable).get();
        final logs = await (db.select(db.habitLogsTable)
              ..where((t) => t.date.isBetweenValues(startOfDay, endOfDay)))
            .get();

        final habitLogsMap = <String, List<HabitLog>>{};
        for (final log in logs) {
          habitLogsMap.putIfAbsent(log.habitId, () => []).add(
                habitLogMapper.habitLogFromRow(log),
              );
        }

        final details = <HabitDetails>[];
        for (final r in habitRows) {
          if (sectionId != null && r.sectionId != sectionId) continue;

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
      });
    });
  }

  @override
  Stream<Result<List<SectionWithHabits>>> watchSectionsWithHabitsForDay(
      DateTime day) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = DateTime(day.year, day.month, day.day, 23, 59, 59);

    return db.watchAllSections().asyncMap((sectionRows) async {
      return await guard(() async {
        final habitRows = await db.select(db.habitsTable).get();
        final reminders = await db.select(db.habitRemindersTable).get();
        final logs = await (db.select(db.habitLogsTable)
              ..where((t) => t.date.isBetweenValues(startOfDay, endOfDay)))
            .get();

        // Build domain sections up front (sorted by orderIndex)
        final domainSections = sectionRows.map(sectionFromRow).toList()
          ..sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

        final existingSectionIds = domainSections.map((s) => s.id).toSet();
        final anytimeSection = domainSections
            .where((s) => s.type == SectionType.anytime)
            .cast<Section>()
            .fold<Section?>(null, (prev, s) => prev ?? s);

        // Map logs
        final habitLogsMap = <String, List<HabitLog>>{};
        for (final logRow in logs) {
          habitLogsMap
              .putIfAbsent(logRow.habitId, () => [])
              .add(habitLogMapper.habitLogFromRow(logRow));
        }

        // Prepare buckets for each known section
        final sectionMap = <String, List<HabitDetails>>{
          for (final s in domainSections) s.id: <HabitDetails>[],
        };

        // Fallback key if there's no Anytime section in DB
        const fallbackAnytimeKey = '__anytime_fallback__';
        sectionMap[fallbackAnytimeKey] = <HabitDetails>[];

        // Group habits
        for (final r in habitRows) {
          final habitLogs = habitLogsMap[r.id] ?? [];
          final completed =
              habitLogs.any((l) => l.status == HabitStatus.completed);

          final habitRemindersList = reminders
              .where((m) => m.habitId == r.id)
              .map(habitReminderFromRow)
              .toList();

          final details = HabitDetails(
            habit: habitMapper.habitFromRow(r),
            logs: habitLogs,
            reminders: habitRemindersList,
            isCompletedForDay: completed,
          );

          // ✅ choose the correct bucket
          final sectionId = r.sectionId;
          final bucketId =
              (sectionId != null && existingSectionIds.contains(sectionId))
                  ? sectionId
                  : (anytimeSection?.id ?? fallbackAnytimeKey);

          sectionMap.putIfAbsent(bucketId, () => <HabitDetails>[]).add(details);
        }

        // Build results
        final result = <SectionWithHabits>[];

        for (final s in domainSections) {
          final habits = sectionMap[s.id] ?? const <HabitDetails>[];

          // Sort by title (since Habit lacks orderInSection)
          habits.sort((a, b) => a.habit.title.compareTo(b.habit.title));

          result.add(SectionWithHabits(section: s, habits: habits));
        }

        // If we had to use a fallback "Anytime" (no real section row existed)
        if (anytimeSection == null &&
            (sectionMap[fallbackAnytimeKey]?.isNotEmpty ?? false)) {
          final habits = sectionMap[fallbackAnytimeKey]!
            ..sort((a, b) => a.habit.title.compareTo(b.habit.title));

          result.add(
            SectionWithHabits(
              section: Section(
                id: fallbackAnytimeKey,
                type: SectionType.anytime,
                orderIndex: 999,
              ),
              habits: habits,
            ),
          );
        }

        return result;
      });
    });
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
