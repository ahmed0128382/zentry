import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import '../controllers/task_list_controller.dart';
import 'task_repo_provider.dart';

// provider kept the same name: state is AsyncValue<List<Task>>
final taskListControllerProvider =
    StateNotifierProvider<TaskListController, AsyncValue<List<Task>>>((ref) {
  final repo = ref.watch(taskRepoProvider);
  return TaskListController(repo);
});
