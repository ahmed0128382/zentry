import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/task_list_controller.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';

final taskListControllerProvider =
    StateNotifierProvider<TaskListController, List<Task>>(
  (ref) => TaskListController(),
);
