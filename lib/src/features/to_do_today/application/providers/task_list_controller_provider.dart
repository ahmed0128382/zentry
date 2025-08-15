import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/task_list_controller.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_repo_provider.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';

final taskListControllerProvider =
    StateNotifierProvider<TaskListController, AsyncValue<List<Task>>>((ref) {
  final repo = ref.watch(taskRepoProvider);
  return TaskListController(repo);
});
