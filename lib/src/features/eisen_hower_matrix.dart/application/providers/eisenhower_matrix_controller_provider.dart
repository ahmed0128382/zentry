import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/controllers/eisenhower_matrix_controller.dart';

final eisenhowerMatrixControllerProvider =
    StateNotifierProvider<EisenhowerMatrixController, bool>((ref) {
  return EisenhowerMatrixController();
});
