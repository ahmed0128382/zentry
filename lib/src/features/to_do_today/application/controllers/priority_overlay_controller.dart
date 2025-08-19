import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

class PriorityOverlayController extends StateNotifier<TaskPriority> {
  PriorityOverlayController() : super(TaskPriority.noPriority);

  void selectPriority(TaskPriority priority) {
    state = priority;
  }

  void clearPriority() {
    state = TaskPriority.noPriority;
  }
}
