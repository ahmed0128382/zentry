import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import 'package:zentry/src/shared/domain/repos/task_repo.dart';

class TaskListController extends StateNotifier<AsyncValue<List<Task>>> {
  final TaskRepository _repo;

  TaskListController(this._repo) : super(const AsyncValue.loading()) {
    _init();
  }

  Future<void> _init() async {
    await loadTasks();
    // If your repo supports streaming:
    // _repo.watchAllTasks().listen((tasks) {
    //   state = AsyncValue.data(tasks);
    // }, onError: (err, st) {
    //   state = AsyncValue.error(err, st);
    // });
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
    final prev = state.value ?? [];
    state = AsyncValue.data([...prev, task]); // optimistic
    log("DEBUG: Adding Task in TaskListController with priority: ${task.priority}");
    try {
      await _repo.addTask(task);
      await loadTasks();
    } catch (e, st) {
      state = AsyncValue.data(prev); // rollback
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> toggleCompletion(String taskId) async {
    bool? newValue;

    // 1️⃣ Optimistic UI update
    state = state.whenData((tasks) {
      return tasks.map((task) {
        if (task.id == taskId) {
          newValue = !task.isCompleted;
          return task.copyWith(isCompleted: newValue);
        }
        return task;
      }).toList();
    });

    if (newValue == null) return; // task not found

    // 2️⃣ Persist the change
    await _repo.updateTaskCompletion(taskId, newValue!);
  }

  Future<void> editTask(Task updatedTask) async {
    final prev = state.value ?? [];
    final updated =
        prev.map((t) => t.id == updatedTask.id ? updatedTask : t).toList();

    state = AsyncValue.data(updated); // optimistic
    try {
      await _repo.updateTask(updatedTask);
    } catch (e, st) {
      state = AsyncValue.data(prev); // rollback
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteTask(String id) async {
    final prev = state.value ?? [];
    final updated = prev.where((t) => t.id != id).toList();

    state = AsyncValue.data(updated); // optimistic
    try {
      await _repo.deleteTask(id);
    } catch (e, st) {
      state = AsyncValue.data(prev); // rollback
      state = AsyncValue.error(e, st);
    }
  }
}
