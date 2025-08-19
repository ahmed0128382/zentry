import 'package:drift/drift.dart' as drift;
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final bool isCompleted;
  final TaskPriority priority;

  Task({
    required this.id,
    required this.title,
    this.description,
    DateTime? createdAt,
    this.isCompleted = false,
    required this.priority,
  }) : createdAt = createdAt ?? DateTime.now();

  Task copyWith({
    String? title,
    String? description,
    bool? isCompleted,
    TaskPriority? priority,
  }) {
    return Task(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
      priority: priority ?? this.priority,
    );
  }

  factory Task.fromDb(TasksTableData data) {
    final priority = TaskPriorityExtension.fromString(data.priority);

    // Debug log
    print('DEBUG: Creating Task from DB -> '
        'id: ${data.id}, title: ${data.title}, priority: ${data.priority} '
        '(converted to enum: $priority)');
    return Task(
      id: data.id,
      title: data.title,
      description: data.description,
      createdAt: data.createdAt,
      isCompleted: data.isCompleted,
      priority: data.priority != null
          ? TaskPriority.values.firstWhere(
              (e) => e.name == data.priority,
              orElse: () => TaskPriority.noPriority,
            )
          : TaskPriority.noPriority,
    );
  }

  TasksTableCompanion toDb() {
    return TasksTableCompanion(
      id: drift.Value(id),
      title: drift.Value(title),
      description: drift.Value(description ?? ''),
      createdAt: drift.Value(createdAt),
      isCompleted: drift.Value(isCompleted),
      priority: drift.Value(priority.name),
    );
  }
}

extension TaskPriorityExtension on TaskPriority {
  static TaskPriority fromString(String? value) {
    if (value == null) return TaskPriority.noPriority;
    return TaskPriority.values.firstWhere(
      (e) => e.name == value,
      orElse: () => TaskPriority.noPriority,
    );
  }
}
