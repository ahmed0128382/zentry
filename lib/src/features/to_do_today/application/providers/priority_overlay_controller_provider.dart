import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/priority_overlay_controller.dart';
import 'package:zentry/src/shared/enums/tasks_priority.dart';

final priorityOverlayControllerProvider =
    StateNotifierProvider<PriorityOverlayController, TaskPriority>(
        (ref) => PriorityOverlayController());
