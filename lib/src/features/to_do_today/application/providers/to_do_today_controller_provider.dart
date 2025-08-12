import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/to_do_today/application/controllers/to_do_today_controller.dart';

final toDoTodayControllerProvider =
    StateNotifierProvider<ToDoTodayController, bool>((ref) {
  return ToDoTodayController();
});
