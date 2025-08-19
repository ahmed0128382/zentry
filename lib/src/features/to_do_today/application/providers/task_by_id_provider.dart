// // Add this provider
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/to_do_today/application/providers/task_repo_provider.dart';
// import 'package:zentry/src/shared/domain/entities/task.dart';

// final taskByIdProvider =
//     FutureProvider.family<Task?, String>((ref, taskId) async {
//   final repo = ref.watch(taskRepoProvider);
//   return repo.getTaskById(taskId);
// });
