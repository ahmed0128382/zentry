import 'package:zentry/src/shared/enums/tasks_priority.dart';

class TaskEntity {
  final String id;
  final String title;
  final DateTime date;
  final bool isDone;
  final TaskPriority priority;

  TaskEntity({
    required this.id,
    required this.title,
    required this.date,
    required this.isDone,
    required this.priority,
  });
}
