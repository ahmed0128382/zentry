import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';

class TaskTile extends ConsumerWidget {
  final Task task;
  final void Function(bool?)? onChanged;
  final VoidCallback? onTap;

  const TaskTile({
    super.key,
    required this.task,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Checkbox toggle
          Checkbox(
            value: task.isCompleted,
            activeColor: palette.primary,
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
                      color: task.isCompleted ? Colors.grey : null,
                    ),
                  ),
                  if (task.createdAt != null)
                    Text(task.createdAt.toIso8601String(),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
