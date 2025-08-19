import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/entities/quadrant.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/presentation/views/widgets/eisenhower_matrix_header.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_list_controller_provider.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';
import '../widgets/quadrant_widget.dart';

class EisenhowerMatrixViewBody extends ConsumerWidget {
  const EisenhowerMatrixViewBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(taskListControllerProvider);
    final taskController = ref.read(taskListControllerProvider.notifier);

    return tasksAsync.when(
      data: (tasks) {
        // Map tasks to quadrants
        final quadrants = QuadrantType.values.map((type) {
          final quadrantTasks = tasks.where((task) {
            switch (type) {
              case QuadrantType.urgentImportant:
                return task.priority == TaskPriority.highPriority;
              case QuadrantType.notUrgentImportant:
                return task.priority == TaskPriority.mediumPriority;
              case QuadrantType.urgentNotImportant:
                return task.priority == TaskPriority.lowPriority;
              case QuadrantType.notUrgentNotImportant:
                return task.priority == TaskPriority.noPriority;
            }
          }).toList();

          return Quadrant(type: type, tasks: quadrantTasks);
        }).toList();

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                const EisenhowerMatrixHeader(),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: QuadrantWidget(
                          quadrantType: QuadrantType.urgentImportant,
                          tasks: quadrants,
                          onToggleCompletion: (task, newValue) {
                            if (newValue != null) {
                              taskController.toggleCompletion(task.id);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: QuadrantWidget(
                          quadrantType: QuadrantType.notUrgentImportant,
                          tasks: quadrants,
                          onToggleCompletion: (task, newValue) {
                            if (newValue != null) {
                              taskController.toggleCompletion(task.id);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: QuadrantWidget(
                          quadrantType: QuadrantType.urgentNotImportant,
                          tasks: quadrants,
                          onToggleCompletion: (task, newValue) {
                            if (newValue != null) {
                              taskController.toggleCompletion(task.id);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: QuadrantWidget(
                          quadrantType: QuadrantType.notUrgentNotImportant,
                          tasks: quadrants,
                          onToggleCompletion: (task, newValue) {
                            if (newValue != null) {
                              taskController.toggleCompletion(task.id);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}
