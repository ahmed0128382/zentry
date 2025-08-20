import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_details_controller_provider.dart';

class TaskHeader extends ConsumerWidget {
  final Task task;
  final ValueChanged<bool> onToggle;

  const TaskHeader({super.key, required this.task, required this.onToggle});

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.highPriority:
        return Colors.red;
      case TaskPriority.mediumPriority:
        return Colors.orange;
      case TaskPriority.lowPriority:
        return Colors.green;
      case TaskPriority.noPriority:
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = task.isCompleted ? Colors.green : Colors.red;

    // Watch the task details state
    final taskState = ref.watch(taskDetailsControllerProvider(task.id));
    final priority = taskState.value?.priorityDraft ?? task.priority;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
          value: task.isCompleted,
          onChanged: (v) => onToggle(v ?? false),
          activeColor: statusColor,
          side: BorderSide(color: _getPriorityColor(priority), width: 1.5),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            child: Text(
              task.isCompleted ? 'Completed' : 'In progress',
              key: ValueKey(task.isCompleted),
              style: TextStyle(fontWeight: FontWeight.w600, color: statusColor),
            ),
          ),
        ),

        // Priority Popup
        PopupMenuButton<TaskPriority>(
          tooltip: 'Set priority',
          icon: Icon(
            Icons.flag,
            color: _getPriorityColor(priority),
          ),
          onSelected: (selectedPriority) {
            ref
                .read(taskDetailsControllerProvider(task.id).notifier)
                .setPriority(selectedPriority);
          },
          itemBuilder: (context) => TaskPriority.values.map((p) {
            return PopupMenuItem<TaskPriority>(
              value: p,
              child: Row(
                children: [
                  Icon(Icons.flag, size: 14, color: _getPriorityColor(p)),
                  const SizedBox(width: 8),
                  Text(p.name.toUpperCase()),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
