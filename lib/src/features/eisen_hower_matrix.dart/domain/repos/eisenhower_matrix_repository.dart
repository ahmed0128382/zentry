import 'package:zentry/src/shared/domain/entities/task.dart';

abstract class EisenhowerMatrixRepository {
  Future<List<Task>> getAllTasks();
  Future<void> addTask(Task task);
}
