import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/habit_logs_controller.dart';
import 'package:zentry/src/features/habits/application/providers/habit_logs_repo_provider.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';

final habitLogsControllerProvider =
    StateNotifierProvider<HabitLogsController, AsyncValue<List<HabitLog>>>(
  (ref) => HabitLogsController(ref.read(habitLogsRepoProvider)),
);
