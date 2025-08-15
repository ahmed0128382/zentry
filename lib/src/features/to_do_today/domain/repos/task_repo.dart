import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Future<Task?> getTaskById(String id);
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getIncompleteTasks();

  Future<void> addTask(Task task);

  /// Update the entire task (title, description, completion, etc.)
  Future<void> updateTask(Task task);

  /// Shortcut to only update completion
  Future<void> updateTaskCompletion(String id, bool isCompleted);
  Future<void> deleteTask(String id);
}
