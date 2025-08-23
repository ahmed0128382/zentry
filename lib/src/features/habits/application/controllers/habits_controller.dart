// File: src/features/habits/application/controllers/habits_controller.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/usecases/add_habit.dart';
import 'package:zentry/src/features/habits/domain/usecases/delete_habit.dart';
import 'package:zentry/src/features/habits/domain/usecases/get_habits_for_day.dart';
import 'package:zentry/src/features/habits/domain/usecases/log_habit_completion.dart';
import 'package:zentry/src/features/habits/domain/usecases/move_habit_to_section.dart';
import 'package:zentry/src/features/habits/domain/usecases/reorder_habits_within_section.dart';
import 'package:zentry/src/features/habits/domain/usecases/update_habit.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

class HabitsState {
  final List<HabitDetails> habits;
  final bool isLoading;
  final String? error;

  HabitsState({
    required this.habits,
    this.isLoading = false,
    this.error,
  });

  HabitsState copyWith({
    List<HabitDetails>? habits,
    bool? isLoading,
    String? error,
  }) {
    return HabitsState(
      habits: habits ?? this.habits,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HabitsController extends StateNotifier<HabitsState> {
  final GetHabitsForDay getHabitsForDay;
  final AddHabit addHabit;
  final UpdateHabit updateHabit;
  final DeleteHabit deleteHabit;
  final MoveHabitToSection moveHabitToSection;
  final ReorderHabitsWithinSection reorderHabitsWithinSection;
  final LogHabitCompletion logHabitCompletion;

  HabitsController({
    required this.getHabitsForDay,
    required this.addHabit,
    required this.updateHabit,
    required this.deleteHabit,
    required this.moveHabitToSection,
    required this.reorderHabitsWithinSection,
    required this.logHabitCompletion,
  }) : super(HabitsState(habits: []));

  // Watch habits for a specific day
  void watchHabits(DateTime day, {String? sectionId}) {
    state = state.copyWith(isLoading: true);
    getHabitsForDay(day: day, sectionId: sectionId).listen((result) {
      result.fold(
        (failure) =>
            state = state.copyWith(error: failure.toString(), isLoading: false),
        (habits) => state = state.copyWith(habits: habits, isLoading: false),
      );
    });
  }

  Future<void> add(Habit habit) async {
    final result = await addHabit(habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (habit) => watchHabits(DateTime.now()),
    );
  }

  Future<void> update(Habit habit) async {
    final result = await updateHabit(habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (habit) => watchHabits(DateTime.now()),
    );
  }

  Future<void> delete(String habitId) async {
    final result = await deleteHabit(habitId);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(DateTime.now()),
    );
  }

  Future<void> logCompletion(HabitDetails habit) async {
    final result = await logHabitCompletion(habit.toHabitLog());
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(DateTime.now()),
    );
  }

  Future<void> moveToSection(
      String habitId, String newSectionId, int newIndex) async {
    final result = await moveHabitToSection(
      habitId: habitId,
      newSectionId: newSectionId,
      newOrderIndex: newIndex,
    );
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(DateTime.now()),
    );
  }

  Future<void> reorder(String sectionId, List<String> orderedIds) async {
    final result = await reorderHabitsWithinSection(
        sectionId: sectionId, orderedHabitIds: orderedIds);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(DateTime.now()),
    );
  }
}
