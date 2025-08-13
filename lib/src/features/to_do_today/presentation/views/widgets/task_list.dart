import 'package:flutter/material.dart';
import 'package:zentry/src/features/to_do_today/domain/entities/task.dart';
import 'package:zentry/src/features/to_do_today/presentation/views/widgets/task_item.dart';

class TaskList extends StatelessWidget {
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

  String _formatTime(DateTime time) {
    return "${time.day} ${_monthAbbreviation(time.month)}";
  }

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          ...tasks.map((task) {
            return GestureDetector(
              onTap: () => onTapTask?.call(task),
              child: TaskItem(
                key: ValueKey(task.id),
                title: task.title,
                time: _formatTime(task.createdAt),
                isCompleted: task.isCompleted,
                showRefresh: false,
                onChanged: (newValue) =>
                    onToggleCompletion?.call(task, newValue),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
