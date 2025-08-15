import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/domain/repos/task_repo.dart';
import 'package:zentry/src/features/to_do_today/infrastructure/repos/tasks_repo_impl.dart';

/// Singleton TaskRepository instance
final taskRepoProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TaskRepositoryImpl(db);
});

// Add this provider
final taskByIdProvider =
    FutureProvider.family<Task?, String>((ref, taskId) async {
  final repo = ref.watch(taskRepoProvider);
  return repo.getTaskById(taskId);
});
