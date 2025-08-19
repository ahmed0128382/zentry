import '../entities/task.dart';

abstract class TaskRepository {
  Future<List<Task>> getAllTasks();
  Stream<List<Task>> watchAllTasks(); // <-- new
  Future<Task?> getTaskById(String id);
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getIncompleteTasks();

  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> updateTaskCompletion(String id, bool isCompleted);
  Future<void> deleteTask(String id);
}
