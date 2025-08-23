import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/application/providers/habit_logs_repo_provider.dart';
import 'package:zentry/src/features/habits/application/providers/habit_repo_provider.dart';
import '../../domain/usecases/add_habit.dart';
import '../../domain/usecases/delete_habit.dart';
import '../../domain/usecases/get_habits_for_day.dart';
import '../../domain/usecases/log_habit_completion.dart';
import '../../domain/usecases/move_habit_to_section.dart';
import '../../domain/usecases/reorder_habits_within_section.dart';
import '../../domain/usecases/update_habit.dart';

// Use cases providers
final getHabitsForDayProvider = Provider<GetHabitsForDay>((ref) {
  return GetHabitsForDay(ref.read(habitRepositoryProvider));
});

final addHabitProvider = Provider<AddHabit>((ref) {
  return AddHabit(ref.read(habitRepositoryProvider));
});

final updateHabitProvider = Provider<UpdateHabit>((ref) {
  return UpdateHabit(ref.read(habitRepositoryProvider));
});

final deleteHabitProvider = Provider<DeleteHabit>((ref) {
  return DeleteHabit(ref.read(habitRepositoryProvider));
});

final moveHabitToSectionProvider = Provider<MoveHabitToSection>((ref) {
  return MoveHabitToSection(ref.read(habitRepositoryProvider));
});

final reorderHabitsWithinSectionProvider =
    Provider<ReorderHabitsWithinSection>((ref) {
  return ReorderHabitsWithinSection(ref.read(habitRepositoryProvider));
});

final logHabitCompletionProvider = Provider<LogHabitCompletion>((ref) {
  return LogHabitCompletion(ref.read(habitLogsRepoProvider));
});
