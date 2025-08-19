import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zentry/src/core/application/providers/app_palette_provider.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/task_tile.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import '../../../domain/entities/quadrant.dart';
import '../../../domain/enums/quadrant_type_enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuadrantWidget extends ConsumerWidget {
  final QuadrantType quadrantType;
  final List<Quadrant> tasks;
  final void Function(Task task, bool? newValue)? onToggleCompletion;
  final void Function(Task task)? onTapTask;

  const QuadrantWidget({
    super.key,
    required this.quadrantType,
    required this.tasks,
    this.onToggleCompletion,
    this.onTapTask,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(appPaletteProvider);
    final quadrant = tasks.firstWhere(
      (q) => q.type == quadrantType,
      orElse: () => Quadrant(type: quadrantType, tasks: []),
    );

    final title = _getQuadrantTitle(quadrantType);
    final color = _getQuadrantColor(quadrantType);
    final icon = _getQuadrantIcon(quadrantType);

    return Container(
      decoration: BoxDecoration(
        color: palette.secondary.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: palette.secondary.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 16),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (quadrant.tasks.isEmpty)
            Expanded(
              child: Center(
                child: Text('No Tasks',
                    style: TextStyle(
                        color: Colors.grey[400], fontStyle: FontStyle.italic)),
              ),
            )
          else
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: quadrant.tasks
                      .map(
                        (task) => TaskTile(
                          key: ValueKey(task.id),
                          priority: task.priority,
                          task: task,
                          onChanged: (value) {
                            if (onToggleCompletion != null) {
                              onToggleCompletion!(task, value);
                            }
                          },
                          onTap: () {
                            if (onTapTask != null) {
                              onTapTask!(task);
                            } else {
                              context.pushNamed('taskDetails',
                                  pathParameters: {'id': task.id});
                            }
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getQuadrantTitle(QuadrantType type) {
    switch (type) {
      case QuadrantType.urgentImportant:
        return 'Urgent & Important';
      case QuadrantType.notUrgentImportant:
        return 'Not Urgent & Important';
      case QuadrantType.urgentNotImportant:
        return 'Urgent & Unimportant';
      case QuadrantType.notUrgentNotImportant:
        return 'Not Urgent & Unimportant';
    }
  }

  Color _getQuadrantColor(QuadrantType type) {
    switch (type) {
      case QuadrantType.urgentImportant:
        return Colors.red;
      case QuadrantType.notUrgentImportant:
        return Colors.yellow;
      case QuadrantType.urgentNotImportant:
        return Colors.blue;
      case QuadrantType.notUrgentNotImportant:
        return Colors.green;
    }
  }

  IconData _getQuadrantIcon(QuadrantType type) {
    switch (type) {
      case QuadrantType.urgentImportant:
        return Icons.priority_high;
      case QuadrantType.notUrgentImportant:
        return Icons.double_arrow;
      case QuadrantType.urgentNotImportant:
        return Icons.info;
      case QuadrantType.notUrgentNotImportant:
        return Icons.arrow_downward;
    }
  }
}
