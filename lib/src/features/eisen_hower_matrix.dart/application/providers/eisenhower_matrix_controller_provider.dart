import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/controllers/eisenhower_matrix_controller.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/entities/quadrant.dart';
import 'package:zentry/src/features/to_do_today/application/providers/task_repo_provider.dart';

final eisenhowerMatrixControllerProvider =
    StateNotifierProvider<EisenhowerMatrixController, List<Quadrant>>(
  (ref) => EisenhowerMatrixController(ref.read(taskRepoProvider)),
);
