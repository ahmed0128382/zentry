import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'tables/tasks_table.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TasksTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // --- CRUD operations (optional helper methods) ---
  Future<List<TasksTableData>> getAllTasks() => select(tasksTable).get();
  Stream<List<TasksTableData>> watchAllTasks() => select(tasksTable).watch();

  // Fetch only incomplete tasks
  Future<List<TasksTableData>> getIncompleteTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(false)))
        .get();
  }

// Fetch only completed tasks
  Future<List<TasksTableData>> getCompletedTasks() {
    return (select(tasksTable)..where((t) => t.isCompleted.equals(true))).get();
  }

// Optional: watch streams for live updates
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app_database.sqlite'));
    return NativeDatabase(file);
  });
}
