import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/controllers/sections_with_habits_controller.dart';
import 'package:zentry/src/features/habits/application/states/sections_with_habits_state.dart';
import 'package:zentry/src/features/habits/domain/usecases/get_sections_with_habits_for_day.dart';
import 'package:zentry/src/features/habits/application/providers/habit_repo_provider.dart';

final sectionsWithHabitsControllerProvider = StateNotifierProvider.autoDispose<
    SectionsWithHabitsController, SectionsWithHabitsState>((ref) {
  final repo = ref.watch(habitRepositoryProvider);
  return SectionsWithHabitsController(
    getSectionsWithHabitsForDay: GetSectionsWithHabitsForDay(repo),
  );
});
