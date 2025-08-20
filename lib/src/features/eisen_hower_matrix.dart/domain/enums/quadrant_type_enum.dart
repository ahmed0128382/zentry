import 'package:zentry/src/shared/enums/tasks_priority.dart';

enum QuadrantType {
  urgentImportant,
  notUrgentImportant,
  urgentNotImportant,
  notUrgentNotImportant
}

extension QuadrantTypeMapper on QuadrantType {
  TaskPriority toPriority() {
    switch (this) {
      case QuadrantType.urgentImportant:
        return TaskPriority.highPriority;
      case QuadrantType.notUrgentImportant:
        return TaskPriority.mediumPriority;
      case QuadrantType.urgentNotImportant:
        return TaskPriority.lowPriority;
      case QuadrantType.notUrgentNotImportant:
        return TaskPriority.noPriority;
    }
  }
}
