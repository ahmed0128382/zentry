import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

class TaskTile extends ConsumerWidget {
  final Task task;
  final void Function(bool?)? onChanged;
  final VoidCallback? onTap;
  final TaskPriority priority;

  const TaskTile({
    super.key,
    required this.priority,
    required this.task,
    this.onChanged,
    this.onTap,
  });

  Color _priorityColor(TaskPriority priority) {
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Checkbox toggle
          Checkbox(
            value: task.isCompleted,
            activeColor: priorityColor,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8.0),
          // Only the text is tappable
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      decoration:
                          task.isCompleted ? TextDecoration.lineThrough : null,
                      color: palette.icon,
                    ),
                  ),
                  if (task.createdAt != null)
                    Text(task.createdAt.toIso8601String(),
                        style: TextStyle(fontSize: 12, color: palette.icon)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
