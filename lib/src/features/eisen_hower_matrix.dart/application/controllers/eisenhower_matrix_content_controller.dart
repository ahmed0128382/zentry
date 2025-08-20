import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/entities/quadrant.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';
import 'package:zentry/src/shared/domain/repos/task_repo.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart'; // Drift implementation

class EisenhowerMatrixContentController extends StateNotifier<List<Quadrant>> {
  final TaskRepository taskRepository;

  EisenhowerMatrixContentController(this.taskRepository) : super([]) {
    loadTasks();
  }

  Future<void> loadTasks() async {
    final tasks = await taskRepository.getAllTasks();
    state = _mapTasksToQuadrants(tasks);
  }

  List<Quadrant> _mapTasksToQuadrants(List<Task> tasks) {
    return QuadrantType.values.map((type) {
      List<Task> quadrantTasks = tasks.where((task) {
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
  }

  // ✅ Add a new task
  Future<void> addTask(Task task) async {
    await taskRepository.addTask(task); // save in DB
    await loadTasks(); // refresh matrix after adding
  }
}
