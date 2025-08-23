import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/habits_controller.dart';
import 'habit_usecases_providers.dart';

final habitsControllerProvider =
    StateNotifierProvider<HabitsController, HabitsState>((ref) {
  return HabitsController(
    getHabitsForDay: ref.read(getHabitsForDayProvider),
    addHabit: ref.read(addHabitProvider),
    updateHabit: ref.read(updateHabitProvider),
    deleteHabit: ref.read(deleteHabitProvider),
    moveHabitToSection: ref.read(moveHabitToSectionProvider),
    reorderHabitsWithinSection: ref.read(reorderHabitsWithinSectionProvider),
    logHabitCompletion: ref.read(logHabitCompletionProvider),
  );
});
