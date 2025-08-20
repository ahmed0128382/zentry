import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/application/controllers/quadrant_overlay_controller.dart';
import 'package:zentry/src/features/eisen_hower_matrix.dart/domain/enums/quadrant_type_enum.dart';

final quadrantOverlayControllerProvider =
    StateNotifierProvider<QuadrantOverlayController, QuadrantType>(
        (ref) => QuadrantOverlayController());
