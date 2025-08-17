import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_list.dart';

class TaskContent extends ConsumerWidget {
  const TaskContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    final tasksAsync = ref.watch(taskListControllerProvider);
    final taskController = ref.read(taskListControllerProvider.notifier);

    return tasksAsync.when(
      data: (tasks) {
        final inboxTasks = tasks.where((t) => !t.isCompleted).toList();
        final completedTasks = tasks.where((t) => t.isCompleted).toList();

        return SingleChildScrollView(
          child: Column(
            children: [
              TaskList(
                title: 'Inbox',
                tasks: inboxTasks,
                onToggleCompletion: (task, newValue) {
                  if (newValue != null) {
                    taskController.toggleCompletion(task.id);
                  }
                },
              ),
              const Divider(),
              if (completedTasks.isNotEmpty)
                TaskList(
                  title: 'Completed',
                  tasks: completedTasks,
                  onToggleCompletion: (task, newValue) {
                    if (newValue != null) {
                      taskController.toggleCompletion(task.id);
                    }
                  },
                ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
