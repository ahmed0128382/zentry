// File: lib/src/core/data/app_database.dart

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:zentry/constants.dart';

// --- Drift Tables ---
import 'tables/tasks_table.dart';
import 'tables/appearance_table.dart';
import 'tables/habits_table.dart';
import 'tables/habit_logs_table.dart';
import 'tables/habit_reminders_table.dart';
import 'tables/sections_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    TasksTable,
    AppearanceTable,
    HabitsTable,
    HabitLogsTable,
    HabitRemindersTable,
    SectionsTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// bump this when schema changes
  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            await m.addColumn(tasksTable, tasksTable.priority);
          }
          if (from <= 2) {
            await m.createTable(habitsTable);
            await m.createTable(habitLogsTable);
            await m.createTable(habitRemindersTable);
            await m.createTable(sectionsTable);
          }
          if (from <= 3) {
            await m.addColumn(habitsTable, habitsTable.orderInSection);
            await customStatement(
                'UPDATE habits_table SET order_in_section = 0');
          }
        },
      );

  // ----------------- TASKS -----------------
  Future<List<TasksTableData>> getAllTasks() => select(tasksTable).get();
  Stream<List<TasksTableData>> watchAllTasks() => select(tasksTable).watch();

  Future<TasksTableData?> getTaskById(String id) =>
      (select(tasksTable)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<List<TasksTableData>> getIncompleteTasks() =>
      (select(tasksTable)..where((t) => t.isCompleted.equals(false))).get();

  Future<List<TasksTableData>> getCompletedTasks() =>
      (select(tasksTable)..where((t) => t.isCompleted.equals(true))).get();

  Stream<List<TasksTableData>> watchIncompleteTasks() =>
      (select(tasksTable)..where((t) => t.isCompleted.equals(false))).watch();

  Stream<List<TasksTableData>> watchCompletedTasks() =>
      (select(tasksTable)..where((t) => t.isCompleted.equals(true))).watch();

  Future<void> insertTask(TasksTableCompanion task) =>
      into(tasksTable).insert(task);

  Future<void> updateTaskCompletion(String id, bool isCompleted) =>
      (update(tasksTable)..where((t) => t.id.equals(id)))
          .write(TasksTableCompanion(isCompleted: Value(isCompleted)));

  Future<void> updateTask(TasksTableCompanion updatedTask) =>
      update(tasksTable).replace(updatedTask);

  Future<void> deleteTask(String id) =>
      (delete(tasksTable)..where((t) => t.id.equals(id))).go();

  // ----------------- APPEARANCE -----------------
  Future<AppearanceTableData?> getAppearanceSettings() =>
      (select(appearanceTable)..where((t) => t.id.equals(kRowAppearanceId)))
          .getSingleOrNull();

  Stream<AppearanceTableData?> watchAppearanceSettings() =>
      (select(appearanceTable)..where((t) => t.id.equals(kRowAppearanceId)))
          .watchSingleOrNull();

  // ----------------- HABITS -----------------
  Future<void> insertHabit(HabitsTableCompanion habit) =>
      into(habitsTable).insert(habit);

  Stream<List<HabitRow>> watchAllHabits() => select(habitsTable).watch();

  Future<HabitRow?> getHabitById(String id) =>
      (select(habitsTable)..where((h) => h.id.equals(id))).getSingleOrNull();

  Future<void> deleteHabit(String id) =>
      (delete(habitsTable)..where((h) => h.id.equals(id))).go();

  Future<void> updateHabit(HabitsTableCompanion updatedHabit) =>
      update(habitsTable).replace(updatedHabit);

  Stream<List<HabitRow>> watchHabitsInSection(String sectionId) {
    return (select(habitsTable)
          ..where((h) => h.sectionId.equals(sectionId))
          ..orderBy([(t) => OrderingTerm(expression: t.orderInSection)]))
        .watch();
  }

  Future<void> reorderHabitsInSection(
      String sectionId, List<String> orderedHabitIds) async {
    for (var i = 0; i < orderedHabitIds.length; i++) {
      final habitId = orderedHabitIds[i];
      await (update(habitsTable)..where((t) => t.id.equals(habitId)))
          .write(HabitsTableCompanion(orderInSection: Value(i)));
    }
  }

  // ----------------- HABIT LOGS -----------------
  Future<HabitLogRow> insertOrUpdateHabitLog(
      HabitLogsTableCompanion log) async {
    return into(habitLogsTable).insertReturning(
      log,
      onConflict: DoUpdate((old) => log),
    );
  }

  Future<int> deleteHabitLog(String logId) {
    return (delete(habitLogsTable)..where((t) => t.id.equals(logId))).go();
  }

  Future<List<HabitLogRow>> getLogsForHabit({
    required String habitId,
    required DateTime from,
    required DateTime to,
  }) {
    return (select(habitLogsTable)
          ..where((t) => t.habitId.equals(habitId))
          ..where((t) => t.date.isBetweenValues(from, to)))
        .get();
  }

  Future<List<HabitLogRow>> getLogsForDate(DateTime date) {
    return (select(habitLogsTable)..where((t) => t.date.equals(date))).get();
  }

  // ----------------- HABIT REMINDERS -----------------
  Future<List<HabitRemindersTableData>> getRemindersForHabit(String habitId) {
    return (select(habitRemindersTable)
          ..where((r) => r.habitId.equals(habitId)))
        .get();
  }

  Future<HabitRemindersTableData> insertReminder(
      HabitRemindersTableCompanion reminder) {
    return into(habitRemindersTable).insertReturning(reminder);
  }

  /// Update by id, then return the updated row.
  Future<HabitRemindersTableData?> updateReminder(
      HabitRemindersTableCompanion reminder) async {
    // Expect reminder.id to be present
    if (reminder.id.present == false) {
      // No id to match on -> can't update. You can throw or return null.
      return null;
    }
    final id = reminder.id.value;

    await (update(habitRemindersTable)..where((t) => t.id.equals(id)))
        .write(reminder);

    return (select(habitRemindersTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<int> deleteReminder(String reminderId) {
    return (delete(habitRemindersTable)..where((r) => r.id.equals(reminderId)))
        .go();
  }

  // ----------------- SECTIONS -----------------
  Future<List<SectionRow>> getAllSections() => select(sectionsTable).get();

  Future<SectionRow?> getSectionById(String id) =>
      (select(sectionsTable)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<SectionRow> insertSection(SectionsTableCompanion section) {
    return into(sectionsTable).insertReturning(section);
  }

  /// Update by id, then return the updated row (or null if not found).
  Future<SectionRow?> updateSection(SectionsTableCompanion section) async {
    if (!section.id.present) return null;
    final id = section.id.value;

    final ok = await (update(sectionsTable)..where((t) => t.id.equals(id)))
        .write(section);

    // ok is number of rows affected (int). Fetch updated row if > 0
    if (ok > 0) {
      return (select(sectionsTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();
    }
    return null;
  }

  Future<int> deleteSection(String id) {
    return (delete(sectionsTable)..where((s) => s.id.equals(id))).go();
  }

  Future<void> reorderSections(List<String> orderedSectionIds) async {
    for (var i = 0; i < orderedSectionIds.length; i++) {
      final sectionId = orderedSectionIds[i];
      await (update(sectionsTable)..where((s) => s.id.equals(sectionId)))
          .write(SectionsTableCompanion(orderIndex: Value(i)));
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
