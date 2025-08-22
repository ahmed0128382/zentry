// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
// import 'package:zentry/constants.dart';
// import 'package:zentry/src/core/infrastucture/drift/tables/appearance_table.dart';
// import 'tables/tasks_table.dart';

// part 'app_database.g.dart';

// @DriftDatabase(tables: [
//   TasksTable,
//   AppearanceTable,
// ])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());

//   /// bump version because we added `priority` to TasksTable
//   @override
//   int get schemaVersion => 2;

//   @override
//   MigrationStrategy get migration => MigrationStrategy(
//         onCreate: (Migrator m) async {
//           await m.createAll();
//         },
//         onUpgrade: (Migrator m, int from, int to) async {
//           if (from == 1) {
//             // Add the new column safely
//             await m.addColumn(tasksTable, tasksTable.priority);
//           }
//         },
//       );

//   // ----------------- TASKS -----------------
//   // --- CRUD operations (optional helper methods) ---
//   Future<List<TasksTableData>> getAllTasks() => select(tasksTable).get();
//   Stream<List<TasksTableData>> watchAllTasks() => select(tasksTable).watch();

//   Future<TasksTableData?> getTaskById(String id) {
//     return (select(tasksTable)..where((t) => t.id.equals(id)))
//         .getSingleOrNull();
//   }

//   // Fetch only incomplete tasks
//   Future<List<TasksTableData>> getIncompleteTasks() {
//     return (select(tasksTable)..where((t) => t.isCompleted.equals(false)))
//         .get();
//   }

// // Fetch only completed tasks
//   Future<List<TasksTableData>> getCompletedTasks() {
//     return (select(tasksTable)..where((t) => t.isCompleted.equals(true))).get();
//   }

// // Optional: watch streams for live updates
//   Stream<List<TasksTableData>> watchIncompleteTasks() {
//     return (select(tasksTable)..where((t) => t.isCompleted.equals(false)))
//         .watch();
//   }

//   Stream<List<TasksTableData>> watchCompletedTasks() {
//     return (select(tasksTable)..where((t) => t.isCompleted.equals(true)))
//         .watch();
//   }

//   Future<void> insertTask(TasksTableCompanion task) =>
//       into(tasksTable).insert(task);

//   Future<void> updateTaskCompletion(String id, bool isCompleted) {
//     return (update(tasksTable)..where((t) => t.id.equals(id)))
//         .write(TasksTableCompanion(isCompleted: Value(isCompleted)));
//   }

//   Future<void> updateTask(TasksTableCompanion updatedTask) {
//     return update(tasksTable).replace(updatedTask);
//   }

//   Future<void> deleteTask(String id) =>
//       (delete(tasksTable)..where((t) => t.id.equals(id))).go();

//   // ----------------- APPEARANCE -----------------
//   Future<AppearanceTableData?> getAppearanceSettings() {
//     return (select(appearanceTable)
//           ..where((t) => t.id.equals(kRowAppearanceId)))
//         .getSingleOrNull();
//   }

//   Stream<AppearanceTableData?> watchAppearanceSettings() {
//     return (select(appearanceTable)
//           ..where((t) => t.id.equals(kRowAppearanceId)))
//         .watchSingleOrNull();
//   }
// }

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final dbFolder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
//     return NativeDatabase(file);
//   });
// }
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
  int get schemaVersion => 3;

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
        },
      );

  // ----------------- TASKS -----------------
  Future<List<TasksTableData>> getAllTasks() => select(tasksTable).get();
  Stream<List<TasksTableData>> watchAllTasks() => select(tasksTable).watch();

  Future<TasksTableData?> getTaskById(String id) {
    return (select(tasksTable)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<TasksTableData>> getIncompleteTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(false)))
        .get();
  }

  Future<List<TasksTableData>> getCompletedTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(true))).get();
  }

  Stream<List<TasksTableData>> watchIncompleteTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(false)))
        .watch();
  }

  Stream<List<TasksTableData>> watchCompletedTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(true)))
        .watch();
  }

  Future<void> insertTask(TasksTableCompanion task) =>
      into(tasksTable).insert(task);

  Future<void> updateTaskCompletion(String id, bool isCompleted) {
    return (update(tasksTable)..where((t) => t.id.equals(id)))
        .write(TasksTableCompanion(isCompleted: Value(isCompleted)));
  }

  Future<void> updateTask(TasksTableCompanion updatedTask) {
    return update(tasksTable).replace(updatedTask);
  }

  Future<void> deleteTask(String id) =>
      (delete(tasksTable)..where((t) => t.id.equals(id))).go();

  // ----------------- APPEARANCE -----------------
  Future<AppearanceTableData?> getAppearanceSettings() {
    return (select(appearanceTable)
          ..where((t) => t.id.equals(kRowAppearanceId)))
        .getSingleOrNull();
  }

  Stream<AppearanceTableData?> watchAppearanceSettings() {
    return (select(appearanceTable)
          ..where((t) => t.id.equals(kRowAppearanceId)))
        .watchSingleOrNull();
  }

  // ----------------- HABITS -----------------
  // basic CRUD helpers for habits (DAOs can be extracted later)
  Future<void> insertHabit(HabitsTableCompanion habit) =>
      into(habitsTable).insert(habit);

  Stream<List<HabitRow>> watchAllHabits() => select(habitsTable).watch();

  Future<HabitRow?> getHabitById(String id) {
    return (select(habitsTable)..where((h) => h.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> deleteHabit(String id) =>
      (delete(habitsTable)..where((h) => h.id.equals(id))).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
