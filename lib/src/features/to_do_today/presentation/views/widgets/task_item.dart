import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';

class TaskItem extends ConsumerWidget {
  final String title;
  final String time;
  final bool isCompleted;
  final bool showRefresh;
  final void Function(bool?)? onChanged;

  const TaskItem({
    super.key,
    required this.title,
    required this.time,
    required this.isCompleted,
    required this.showRefresh,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Checkbox(
            value: isCompleted,
            onChanged: onChanged,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
                color: isCompleted ? Colors.grey : Colors.black,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: palette.text),
          ),
        ],
      ),
    );
  }
}
