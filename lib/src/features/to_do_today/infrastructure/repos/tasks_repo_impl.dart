import 'dart:developer';

import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/domain/repos/task_repo.dart';
import 'package:drift/drift.dart';

class TaskRepositoryImpl implements TaskRepository {
  final AppDatabase db;

  TaskRepositoryImpl(this.db);

  @override
  Future<List<Task>> getAllTasks() async {
    final raw = await db.getAllTasks();
    return raw.map<Task>((row) => Task.fromDb(row)).toList();
  }

  @override
  Future<Task?> getTaskById(String id) async {
    final taskRow = await db.getTaskById(id);
    return taskRow != null ? Task.fromDb(taskRow) : null;
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    final raw = await db.getCompletedTasks();

    // Log raw DB rows
    for (var r in raw) {
      log('DEBUG: Raw DB completed task -> id: ${r.id}, title: ${r.title}, priority: ${r.priority}');
    }

    final tasks = raw.map(Task.fromDb).toList();

    // Log after converting to Task entity
    for (var t in tasks) {
      log('DEBUG: Converted completed Task -> id: ${t.id}, title: ${t.title}, priority: ${t.priority}');
    }

    return tasks;
  }

  @override
  Future<List<Task>> getIncompleteTasks() async {
    final raw = await db.getIncompleteTasks();

    // Log raw DB rows
    for (var r in raw) {
      log('DEBUG: Raw DB incomplete task -> id: ${r.id}, title: ${r.title}, priority: ${r.priority}');
    }

    final tasks = raw.map(Task.fromDb).toList();

    // Log after converting to Task entity
    for (var t in tasks) {
      log('DEBUG: Converted incomplete Task -> id: ${t.id}, title: ${t.title}, priority: ${t.priority}');
    }

    return tasks;
  }

  @override
  Future<void> addTask(Task task) async {
    log('DEBUG: Adding Task in TaskRepositoryImpl with priority: ${task.priority}');
    await db.insertTask(
      TasksTableCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        createdAt: Value(task.createdAt),
        isCompleted: Value(task.isCompleted),
        priority: Value(task.priority.name),
      ),
    );
  }

  @override
  Stream<List<Task>> watchAllTasks() {
    return db.watchAllTasks().map((rows) => rows.map(Task.fromDb).toList());
  }

  @override
  Future<void> updateTaskCompletion(String id, bool isCompleted) async {
    await db.updateTaskCompletion(id, isCompleted);
  }

  @override
  Future<void> deleteTask(String id) async {
    await db.deleteTask(id);
  }

  @override
  Future<void> updateTask(Task task) async {
    await db.updateTask(
      TasksTableCompanion(
        id: Value(task.id),
        title: Value(task.title),
        description: Value(task.description),
        createdAt: Value(task.createdAt),
        isCompleted: Value(task.isCompleted),
        priority: Value(task.priority.name),
      ),
    );
  }
}
