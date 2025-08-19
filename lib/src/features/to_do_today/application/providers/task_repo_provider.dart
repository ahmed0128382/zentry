import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_database_provider.dart';
import 'package:zentry/src/shared/domain/repos/task_repo.dart';
import 'package:zentry/src/features/to_do_today/infrastructure/repos/tasks_repo_impl.dart';

/// Singleton TaskRepository instance
final taskRepoProvider = Provider<TaskRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TaskRepositoryImpl(db);
});
