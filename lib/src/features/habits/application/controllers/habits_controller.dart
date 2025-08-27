// import 'dart:developer' as developer;
// import 'dart:developer';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/usecases/add_habit.dart';
// import 'package:zentry/src/features/habits/domain/usecases/delete_habit.dart';
// import 'package:zentry/src/features/habits/domain/usecases/get_habits_for_day.dart';
// import 'package:zentry/src/features/habits/domain/usecases/log_habit_completion.dart';
// import 'package:zentry/src/features/habits/domain/usecases/move_habit_to_section.dart';
// import 'package:zentry/src/features/habits/domain/usecases/reorder_habits_within_section.dart';
// import 'package:zentry/src/features/habits/domain/usecases/update_habit.dart';
// import 'package:zentry/src/shared/domain/entities/habit.dart';
// import 'package:zentry/src/shared/domain/errors/result.dart';

// class HabitsState {
//   final List<HabitDetails> habits;
//   final bool isLoading;
//   final String? error;

//   HabitsState({
//     required this.habits,
//     this.isLoading = false,
//     this.error,
//   });

//   HabitsState copyWith({
//     List<HabitDetails>? habits,
//     bool? isLoading,
//     String? error,
//   }) {
//     return HabitsState(
//       habits: habits ?? this.habits,
//       isLoading: isLoading ?? this.isLoading,
//       error: error,
//     );
//   }
// }

// class HabitsController extends StateNotifier<HabitsState> {
//   final GetHabitsForDay getHabitsForDay;
//   final AddHabit addHabit;
//   final UpdateHabit updateHabit;
//   final DeleteHabit deleteHabit;
//   final MoveHabitToSection moveHabitToSection;
//   final ReorderHabitsWithinSection reorderHabitsWithinSection;
//   final LogHabitCompletion logHabitCompletion;

//   Stream<Result<List<HabitDetails>>>? _currentStream;
//   DateTime currentDay = DateTime.now();

//   HabitsController({
//     required this.getHabitsForDay,
//     required this.addHabit,
//     required this.updateHabit,
//     required this.deleteHabit,
//     required this.moveHabitToSection,
//     required this.reorderHabitsWithinSection,
//     required this.logHabitCompletion,
//   }) : super(HabitsState(habits: []));

//   void watchHabits(DateTime day) {
//     currentDay = day;
//     state = state.copyWith(isLoading: true, error: null);

//     _currentStream = getHabitsForDay(day: day);
//     _currentStream!.listen((result) {
//       result.fold(
//         (failure) {
//           log('[Controller] Failed to load habits: $failure');
//           state = state.copyWith(error: failure.toString(), isLoading: false);
//         },
//         (habits) {
//           log('[Controller] Loaded ${habits.length} habits for $day');
//           state = state.copyWith(habits: habits, isLoading: false);
//         },
//       );
//     });
//   }

//   Future<void> add(Habit habit) async {
//     log('[Controller] Adding habit: ${habit.title}');
//     final result = await addHabit(habit);
//     result.fold(
//       (failure) {
//         log('[Controller] Failed to add habit: $failure');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         log('[Controller] Habit added: ${habit.id}');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> update(Habit habit) async {
//     final result = await updateHabit(habit);
//     result.fold(
//       (failure) {
//         developer.log('Failed to update habit: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (habit) {
//         developer.log('Habit updated: ${habit.id}', name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> delete(String habitId) async {
//     final result = await deleteHabit(habitId);
//     result.fold(
//       (failure) {
//         developer.log('Failed to delete habit: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         developer.log('Habit deleted: $habitId', name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> addOrUpdateLog({
//     required String habitId,
//     required HabitStatus status,
//   }) async {
//     final today = DateTime.now();
//     final log = HabitLog(
//       id: '${habitId}_${today.toIso8601String()}',
//       habitId: habitId,
//       date: today,
//       status: status,
//     );

//     final result = await logHabitCompletion(log); // ✅ use the use case
//     result.fold(
//       (failure) {
//         developer.log('Failed to add/update log: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         developer.log('Log added/updated for habit: $habitId',
//             name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> logCompletion(HabitDetails habit) async {
//     final result = await logHabitCompletion(habit.toHabitLog());
//     result.fold(
//       (failure) {
//         developer.log('Failed to log completion: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         developer.log('Logged completion for habit: ${habit.habit.id}',
//             name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> moveToSection(
//       String habitId, String newSectionId, int newIndex) async {
//     final result = await moveHabitToSection(
//       habitId: habitId,
//       newSectionId: newSectionId,
//       newOrderIndex: newIndex,
//     );
//     result.fold(
//       (failure) {
//         developer.log('Failed to move habit: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         developer.log('Habit moved: $habitId to section $newSectionId',
//             name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> reorder(String sectionId, List<String> orderedIds) async {
//     final result = await reorderHabitsWithinSection(
//         sectionId: sectionId, orderedHabitIds: orderedIds);
//     result.fold(
//       (failure) {
//         developer.log('Failed to reorder habits: ${failure.toString()}',
//             name: 'HabitsController');
//         state = state.copyWith(error: failure.toString());
//       },
//       (_) {
//         developer.log('Reordered habits in section: $sectionId',
//             name: 'HabitsController');
//         watchHabits(currentDay);
//       },
//     );
//   }
// }
// File: src/features/habits/application/controllers/habits_controller.dart

import 'dart:developer' as developer;
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/usecases/add_habit.dart';
import 'package:zentry/src/features/habits/domain/usecases/delete_habit.dart';
import 'package:zentry/src/features/habits/domain/usecases/get_habits_for_day.dart';
import 'package:zentry/src/features/habits/domain/usecases/log_habit_completion.dart';
import 'package:zentry/src/features/habits/domain/usecases/move_habit_to_section.dart';
import 'package:zentry/src/features/habits/domain/usecases/reorder_habits_within_section.dart';
import 'package:zentry/src/features/habits/domain/usecases/update_habit.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';
import 'package:zentry/src/shared/domain/errors/result.dart';

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

  Stream<Result<List<HabitDetails>>>? _currentStream;
  DateTime currentDay = DateTime.now();

  HabitsController({
    required this.getHabitsForDay,
    required this.addHabit,
    required this.updateHabit,
    required this.deleteHabit,
    required this.moveHabitToSection,
    required this.reorderHabitsWithinSection,
    required this.logHabitCompletion,
  }) : super(HabitsState(habits: []));

  void watchHabits(DateTime day) {
    currentDay = day;
    state = state.copyWith(isLoading: true, error: null);

    _currentStream = getHabitsForDay(day: day);
    _currentStream!.listen((result) {
      result.fold(
        (failure) {
          log('[Controller] Failed to load habits: $failure');
          state = state.copyWith(error: failure.toString(), isLoading: false);
        },
        (habits) {
          log('[Controller] Loaded ${habits.length} habits for $day');
          state = state.copyWith(habits: habits, isLoading: false);
        },
      );
    });
  }

  Future<void> add(Habit habit) async {
    log('[Controller] Adding habit: ${habit.title}');
    final result = await addHabit(habit);
    result.fold(
      (failure) {
        log('[Controller] Failed to add habit: $failure');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        log('[Controller] Habit added: ${habit.id}');
        watchHabits(currentDay);
      },
    );
  }

  Future<void> update(Habit habit) async {
    final result = await updateHabit(habit);
    result.fold(
      (failure) {
        developer.log('Failed to update habit: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (habit) {
        developer.log('Habit updated: ${habit.id}', name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }

  Future<void> delete(String habitId) async {
    final result = await deleteHabit(habitId);
    result.fold(
      (failure) {
        developer.log('Failed to delete habit: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Habit deleted: $habitId', name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }

  Future<void> toggleCompletion(HabitDetails hd) async {
    final current = hd.isCompletedForDay; // you already compute this
    final newStatus = current ? HabitStatus.active : HabitStatus.completed;

    final logEntry = HabitLog(
      id: '${hd.habit.id}_${DateTime.now().toIso8601String()}',
      habitId: hd.habit.id,
      date: DateTime.now(),
      status: newStatus,
    );

    final result = await logHabitCompletion(logEntry);
    result.fold(
      (failure) {
        developer.log('Failed to toggle completion: $failure',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Toggled ${hd.habit.title} -> $newStatus',
            name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }

  /// Set or update today's log for a habit to the provided [status].
  /// Uses the LogHabitCompletion usecase (which upserts the log).
  Future<void> setTodayStatus(String habitId, HabitStatus status) async {
    final today = DateTime.now();
    final logEntry = HabitLog(
      id: '${habitId}_${today.toIso8601String()}',
      habitId: habitId,
      date: today,
      status: status,
    );

    final result = await logHabitCompletion(logEntry);
    result.fold(
      (failure) {
        developer.log('Failed to set today status: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Set today status for $habitId -> $status',
            name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }

  /// Convenience: the old "logCompletion" behavior — marks completed using HabitDetails.toHabitLog()
  Future<void> logCompletion(HabitDetails habit) async {
    final result = await logHabitCompletion(habit.toHabitLog());
    result.fold(
      (failure) {
        developer.log('Failed to log completion: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Logged completion for habit: ${habit.habit.id}',
            name: 'HabitsController');
        watchHabits(currentDay);
      },
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
      (failure) {
        developer.log('Failed to move habit: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Habit moved: $habitId to section $newSectionId',
            name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }

  Future<void> reorder(String sectionId, List<String> orderedIds) async {
    final result = await reorderHabitsWithinSection(
        sectionId: sectionId, orderedHabitIds: orderedIds);
    result.fold(
      (failure) {
        developer.log('Failed to reorder habits: ${failure.toString()}',
            name: 'HabitsController');
        state = state.copyWith(error: failure.toString());
      },
      (_) {
        developer.log('Reordered habits in section: $sectionId',
            name: 'HabitsController');
        watchHabits(currentDay);
      },
    );
  }
}
