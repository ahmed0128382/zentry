import 'package:flutter/material.dart';
import '../../../domain/entities/task.dart';

class TaskHeader extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onToggle;

  const TaskHeader({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final statusColor = task.isCompleted ? Colors.green : Colors.orange;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Checkbox(
            value: task.isCompleted, onChanged: (v) => onToggle(v ?? false)),
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
      ],
    );
  }
}
