import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/utils/app_date_utils.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';

class TaskList extends ConsumerWidget {
  final String title;
  final List<Task> tasks;
  final void Function(Task task, bool? newValue)? onToggleCompletion;
  final void Function(Task task)? onTapTask;

  const TaskList({
    required this.title,
    required this.tasks,
    this.onToggleCompletion,
    this.onTapTask,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...tasks.map((task) {
            return GestureDetector(
              onTap: () {
                if (onTapTask != null) {
                  onTapTask!(task);
                } else {
                  context.pushNamed(
                    'taskDetails',
                    pathParameters: {'id': task.id},
                  );
                }
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TaskItem(
                  key: ValueKey(task.id),
                  title: task.title,
                  time: AppDateUtils.formatDayMonth(task.createdAt),
                  isCompleted: task.isCompleted,
                  priority: task.priority, // ✅ required parameter
                  onChanged: (newValue) =>
                      onToggleCompletion?.call(task, newValue),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
