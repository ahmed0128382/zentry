import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_list.dart';

class TaskContent extends ConsumerWidget {
  const TaskContent({super.key});

  String _formatTime(DateTime time) =>
      "${time.day} ${_monthAbbreviation(time.month)}";

  String _monthAbbreviation(int month) {
    const months = [
      '',
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListControllerProvider);
    final taskController = ref.read(taskListControllerProvider.notifier);

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
                taskController.toggleTaskCompletion(task.id, newValue);
              }
            },
            onTapTask: (task) {
              // open bottom sheet for editing
            },
          ),
          const Divider(),
          if (completedTasks.isNotEmpty)
            TaskList(
              title: 'Completed',
              tasks: completedTasks,
              onToggleCompletion: (task, newValue) {
                if (newValue != null) {
                  taskController.toggleTaskCompletion(task.id, newValue);
                }
              },
              onTapTask: (task) {
                // open bottom sheet for editing
              },
            ),
        ],
      ),
    );
  }
}
