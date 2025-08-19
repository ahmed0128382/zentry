import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';
import 'package:zentry/src/shared/domain/entities/task.dart';

class Quadrant {
  final QuadrantType type;
  final List<Task> tasks;

  Quadrant({required this.type, this.tasks = const []});
}
