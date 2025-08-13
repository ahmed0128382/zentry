import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';

class TaskListController extends StateNotifier<List<Task>> {
  TaskListController() : super([]);

  void addTask(Task task) {
    state = [...state, task];
  }

  void toggleTaskCompletion(String taskId, bool isCompleted) {
    state = state.map((task) {
      if (task.id == taskId) return task.copyWith(isCompleted: isCompleted);
      return task;
    }).toList();
  }

  void removeTask(String taskId) {
    state = state.where((task) => task.id != taskId).toList();
  }

  // Edit a task
  void editTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task
    ];
  }
}
