import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/providers/priority_overlay_controller_provider.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

class PriorityOverlay extends ConsumerWidget {
  final VoidCallback? onDismiss;

  const PriorityOverlay({super.key, this.onDismiss});

  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.highPriority:
        return Colors.red;
      case TaskPriority.mediumPriority:
        return Colors.orange;
      case TaskPriority.lowPriority:
        return Colors.green;
      case TaskPriority.noPriority:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPriority = ref.watch(priorityOverlayControllerProvider);

    return PopupMenuButton<TaskPriority>(
      icon: Icon(
        Icons.bookmark_outline,
        color: _getPriorityColor(selectedPriority),
      ),
      onSelected: (priority) {
        ref
            .read(priorityOverlayControllerProvider.notifier)
            .selectPriority(priority);
        if (onDismiss != null) onDismiss!();
      },
      itemBuilder: (context) => TaskPriority.values.map((priority) {
        return PopupMenuItem<TaskPriority>(
          value: priority,
          child: Row(
            children: [
              Icon(Icons.circle, size: 14, color: _getPriorityColor(priority)),
              const SizedBox(width: 8),
              Text(priority.name.toUpperCase()),
            ],
          ),
        );
      }).toList(),
    );
  }
}
