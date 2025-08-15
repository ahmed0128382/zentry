import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/task.dart';
import 'task_repo_provider.dart';

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

  TaskDetailsUiState({
    required this.task,
    this.isSaving = false,
    this.isDeleting = false,
    String? titleDraft,
    String? descriptionDraft,
  })  : titleDraft = titleDraft ?? task.title,
        descriptionDraft = descriptionDraft ?? (task.description ?? '');

  TaskDetailsUiState copyWith({
    Task? task,
    bool? isSaving,
    bool? isDeleting,
    String? titleDraft,
    String? descriptionDraft,
  }) {
    return TaskDetailsUiState(
      task: task ?? this.task,
      isSaving: isSaving ?? this.isSaving,
      isDeleting: isDeleting ?? this.isDeleting,
      titleDraft: titleDraft ?? this.titleDraft,
      descriptionDraft: descriptionDraft ?? this.descriptionDraft,
    );
  }

  bool get hasUnsavedChanges =>
      titleDraft.trim() != (task.title.trim()) ||
      (descriptionDraft.trim()) != ((task.description ?? '').trim());
}
