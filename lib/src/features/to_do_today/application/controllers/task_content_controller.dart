import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/domain/repos/task_repo.dart';

class TaskContentController extends StateNotifier<AsyncValue<Task?>> {
  final TaskRepository _repo;

  TaskContentController(this._repo) : super(const AsyncValue.data(null));

  Future<void> loadTask(String id) async {
    state = const AsyncValue.loading();
    try {
      final task = await _repo.getTaskById(id);
      state = AsyncValue.data(task);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateTask(Task task) async {
    await _repo.updateTask(task);
    state = AsyncValue.data(task);
  }
}
