import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';

class QuadrantOverlayController extends StateNotifier<QuadrantType> {
  QuadrantOverlayController() : super(QuadrantType.notUrgentNotImportant);

  void selectPriority(QuadrantType quadrant) {
    state = quadrant;
  }

  void clearPriority() {
    state = QuadrantType.notUrgentNotImportant;
  }
}
