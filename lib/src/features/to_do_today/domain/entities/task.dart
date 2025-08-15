import 'package:drift/drift.dart' as drift;
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    DateTime? createdAt,
    this.isCompleted = false,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  // Convert DB row to entity
  factory Task.fromDb(TasksTableData data) {
    return Task(
      id: data.id,
      title: data.title,
      description: data.description,
      createdAt: data.createdAt,
      isCompleted: data.isCompleted,
    );
  }

  // Convert entity to DB companion for inserts/updates
  TasksTableCompanion toDb() {
    return TasksTableCompanion(
      id: drift.Value(id),
      title: drift.Value(title),
      description: drift.Value(description),
      createdAt: drift.Value(createdAt),
      isCompleted: drift.Value(isCompleted),
    );
  }
}
