import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

class TaskItem extends ConsumerWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final TaskPriority priority;

  const TaskItem({
    super.key,
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.priority,
    this.onChanged,
  });

  Color _priorityColor(TaskPriority priority) {
    // log(' Priority in TaskItem is $priority');
    switch (priority) {
      case TaskPriority.noPriority:
        return Colors.grey;
      case TaskPriority.lowPriority:
        return Colors.green;
      case TaskPriority.mediumPriority:
        return Colors.orange;
      case TaskPriority.highPriority:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    final priorityColor = _priorityColor(priority);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border.all(color: priorityColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            activeColor: priorityColor,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : palette.icon,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: priorityColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
