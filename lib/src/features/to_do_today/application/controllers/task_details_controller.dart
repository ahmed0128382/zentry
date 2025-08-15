import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_details_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_repo_provider.dart';

/// Riverpod family controller — the `taskId` is passed to `build(taskId)`.
class TaskDetailsController
    extends AutoDisposeFamilyAsyncNotifier<TaskDetailsUiState, String> {
  @override
  Future<TaskDetailsUiState> build(String taskId) async {
    final repo = ref.watch(taskRepoProvider);
    final task = await repo.getTaskById(taskId);
    if (task == null) throw Exception('Task not found');
    return TaskDetailsUiState(task: task);
  }

  // ------ mutations ------

  void setTitle(String v) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(titleDraft: v));
  }

  void setDescription(String v) {
    final current = state.value;
    if (current == null) return;
    state = AsyncData(current.copyWith(descriptionDraft: v));
  }

  Future<void> toggleCompleted(bool value) async {
    final repo = ref.read(taskRepoProvider);
    final taskListCtrl = ref.read(taskListControllerProvider.notifier);
    final current = state.value;
    if (current == null) return;

    // 1️⃣ Optimistic UI update in both places
    // Update TaskDetails UI
    state = AsyncData(
      current.copyWith(
        isCompletedDraft: value,
        task: current.task.copyWith(isCompleted: value),
      ),
    );

    // Update main task list (ToDoTodayView)
    taskListCtrl.state = taskListCtrl.state.whenData((tasks) {
      return tasks.map((t) {
        if (t.id == current.task.id) {
          return t.copyWith(isCompleted: value);
        }
        return t;
      }).toList();
    });

    try {
      // 2️⃣ Persist in DB
      await repo.updateTaskCompletion(current.task.id, value);

      // 3️⃣ Refresh both TaskDetails & main list with fresh DB data
      final freshTask = await repo.getTaskById(current.task.id);
      if (freshTask != null) {
        // Update TaskDetails
        state = AsyncData(
          state.value!.copyWith(
            task: freshTask,
            isCompletedDraft: freshTask.isCompleted,
          ),
        );

        // Update main list
        taskListCtrl.state = taskListCtrl.state.whenData((tasks) {
          return tasks
              .map((t) => t.id == freshTask.id ? freshTask : t)
              .toList();
        });
      }
    } catch (e, st) {
      // Rollback TaskDetails UI if DB fails
      state = AsyncError(e, st);

      // Optionally rollback main list
      await taskListCtrl.loadTasks();
    }
  }

  Future<void> saveEdits() async {
    final repo = ref.read(taskRepoProvider);
    final current = state.value;
    if (current == null) return;

    final newTitle = current.titleDraft.trim();
    final newDescription = current.descriptionDraft.trim().isEmpty
        ? null
        : current.descriptionDraft.trim();

    if (newTitle.isEmpty) {
      state = AsyncError('Title cannot be empty', StackTrace.current);
      return;
    }

    // Nothing changed — no need to update
    if (newTitle == current.task.title &&
        newDescription == current.task.description) {
      return;
    }

    state = AsyncData(current.copyWith(isSaving: true));

    try {
      final updatedTask = current.task.copyWith(
        title: newTitle,
        description: newDescription,
      );

      // Use the controller’s optimistic edit
      await ref.read(taskListControllerProvider.notifier).editTask(updatedTask);

      // Get fresh copy from DB (in case repo adds timestamps, etc.)
      final freshTask = await repo.getTaskById(updatedTask.id) ?? updatedTask;
      state = AsyncData(current.copyWith(task: freshTask, isSaving: false));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteTask() async {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isDeleting: true));

    try {
      await ref
          .read(taskListControllerProvider.notifier)
          .deleteTask(current.task.id);
      // The details screen can listen for removal and pop itself
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Optional explicit refresh (e.g., pull-to-refresh).
  Future<void> refresh() async {
    final repo = ref.read(taskRepoProvider);
    final current = state.value;
    if (current == null) return;
    final fresh = await repo.getTaskById(current.task.id);
    if (fresh != null) {
      state = AsyncData(current.copyWith(task: fresh));
    }
  }
}
