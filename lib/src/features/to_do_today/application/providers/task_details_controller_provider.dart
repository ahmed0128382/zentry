import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/task_details_controller.dart';

import '../../../../shared/domain/entities/task.dart';
import 'task_repo_provider.dart';

/// Provider family you use from the UI: ref.watch(taskDetailsControllerProvider(taskId))
final taskDetailsControllerProvider = AutoDisposeAsyncNotifierProviderFamily<
    TaskDetailsController, TaskDetailsUiState, String>(
  TaskDetailsController.new,
);

/// Loads a task by id — simple, reusable elsewhere if needed.
final taskByIdProvider =
    FutureProvider.family<Task?, String>((ref, taskId) async {
  final repo = ref.watch(taskRepoProvider);
  return repo.getTaskById(taskId);
});

/// UI state for the details screen (keeps local drafts & flags)
class TaskDetailsUiState {
  final Task task; // persisted snapshot
  final bool isSaving;
  final bool isDeleting;
  final String titleDraft; // local draft
  final String descriptionDraft;
  final bool isCompletedDraft;

  TaskDetailsUiState({
    required this.task,
    this.isSaving = false,
    this.isDeleting = false,
    String? titleDraft,
    String? descriptionDraft,
    bool? isCompletedDraft,
  })  : titleDraft = titleDraft ?? task.title,
        descriptionDraft = descriptionDraft ?? (task.description ?? ''),
        isCompletedDraft = isCompletedDraft ?? task.isCompleted;
  TaskDetailsUiState copyWith({
    Task? task,
    bool? isSaving,
    bool? isDeleting,
    String? titleDraft,
    String? descriptionDraft,
    bool? isCompletedDraft,
  }) {
    return TaskDetailsUiState(
      task: task ?? this.task,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      titleDraft: titleDraft ?? this.titleDraft,
      descriptionDraft: descriptionDraft ?? this.descriptionDraft,
      isCompletedDraft: isCompletedDraft ?? this.isCompletedDraft,
    );
  }

  bool get hasUnsavedChanges =>
      titleDraft.trim() != task.title.trim() ||
      descriptionDraft.trim() != (task.description ?? '').trim() ||
      isCompletedDraft != task.isCompleted;
}
