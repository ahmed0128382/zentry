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
    final current = state.value;
    if (current == null) return;

    // optimistic UI
    state = AsyncData(
      current.copyWith(task: current.task.copyWith(isCompleted: value)),
    );
    await repo.updateTaskCompletion(current.task.id, value);

    // ensure we end in sync with persistence
    final fresh = await repo.getTaskById(current.task.id) ?? current.task;
    state = AsyncData(state.value!.copyWith(task: fresh));
  }

  // Future<void> saveEdits() async {
  //   final repo = ref.read(taskRepoProvider);
  //   final current = state.value;
  //   if (current == null) return;

  //   state = AsyncData(current.copyWith(isSaving: true));

  //   final updated = current.task.copyWith(
  //     title: current.titleDraft.trim(),
  //     description: current.descriptionDraft.trim().isEmpty
  //         ? null
  //         : current.descriptionDraft.trim(),
  //   );

  //   await repo.updateTask(updated);

  //   // refresh snapshot from repo if needed
  //   final fresh = await repo.getTaskById(updated.id) ?? updated;
  //   state = AsyncData(
  //     current.copyWith(task: fresh, isSaving: false),
  //   );
  // }
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

      await repo.updateTask(updatedTask);

      // ✅ REFRESH the to-do list provider so ToDoTodayView updates instantly
      ref.invalidate(taskListControllerProvider);

      final freshTask = await repo.getTaskById(updatedTask.id) ?? updatedTask;
      state = AsyncData(
        current.copyWith(task: freshTask, isSaving: false),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteTask() async {
    final repo = ref.read(taskRepoProvider);
    final current = state.value;
    if (current == null) return;

    state = AsyncData(current.copyWith(isDeleting: true));
    await repo.deleteTask(current.task.id);
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

/// Provider family you use from the UI: ref.watch(taskDetailsControllerProvider(taskId))
final taskDetailsControllerProvider = AutoDisposeAsyncNotifierProviderFamily<
    TaskDetailsController, TaskDetailsUiState, String>(
  TaskDetailsController.new,
);
