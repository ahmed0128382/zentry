// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
// import 'package:zentry/src/features/to_do_today/domain/repos/task_repo.dart';

// class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
//   final TaskRepository _repository;

//   TaskListController(this._repository) : super(const AsyncValue.loading()) {
//     loadTasks();
//   }

//   /// Fetch all tasks from DB
//   Future<void> loadTasks() async {
//     state = const AsyncValue.loading();
//     try {
//       final tasks = await _repository.getAllTasks();
//       state = AsyncValue.data(tasks);
//     } catch (e, st) {
//       state = AsyncValue.error(e, st);
//     }
//   }

//   /// Add task
//   Future<void> addTask(Task task) async {
//     await _repository.addTask(task);
//     await loadTasks();
//   }

//   /// Edit entire task
//   Future<void> editTask(Task updatedTask) async {
//     await _repository.updateTask(updatedTask);
//     await loadTasks();
//   }

//   /// Toggle completion only
//   Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
//     await _repository.updateTaskCompletion(taskId, isCompleted);
//     await loadTasks();
//   }

//   /// Delete task
//   Future<void> removeTask(String taskId) async {
//     await _repository.deleteTask(taskId);
//     await loadTasks();
//   }
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/domain/repos/task_repo.dart';

class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
  final TaskRepository _repo;

  TaskListController(this._repo) : super(const AsyncValue.loading()) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    state = const AsyncValue.loading();
    try {
      final tasks = await _repo.getAllTasks();
      state = AsyncValue.data(tasks);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addTask(Task task) async {
    try {
      await _repo.addTask(task);
      await loadTasks();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleTaskCompletion(String taskId, bool isCompleted) async {
    try {
      await _repo.updateTaskCompletion(taskId, isCompleted);

      // Update local state
      state.whenData((tasks) {
        final updated = tasks
            .map((t) =>
                t.id == taskId ? t.copyWith(isCompleted: isCompleted) : t)
            .toList();
        state = AsyncValue.data(updated);
      });
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(String id) async {
    await _repo.deleteTask(id);
    await loadTasks();
  }
}
