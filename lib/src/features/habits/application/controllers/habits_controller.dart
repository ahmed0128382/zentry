// import 'dart:developer' as developer;
// import 'package:flutter/widgets.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
// import 'package:zentry/src/features/habits/domain/entities/section.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
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
//   }) : super(HabitsState(habits: [])) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       watchHabits(currentDay);
//     });
//   }

//   void watchHabits(DateTime day) {
//     currentDay = day;
//     state = state.copyWith(isLoading: true, error: null);

//     _currentStream = getHabitsForDay(day: day);
//     _currentStream!.listen((result) {
//       result.fold(
//         (failure) {
//           developer.log('[Controller] Failed to load habits: $failure');
//           state = state.copyWith(error: failure.toString(), isLoading: false);
//         },
//         (habits) {
//           // ✅ Filter habits that are scheduled for this day
//           final scheduledHabits =
//               habits.where((hd) => hd.habit.isScheduledForDay(day)).toList();

//           developer.log(
//               '[Controller] Loaded ${scheduledHabits.length} habits for $day');
//           state = state.copyWith(habits: scheduledHabits, isLoading: false);
//         },
//       );
//     });
//   }

//   Future<void> add(Habit habit) async {
//     final sectionId = habit.sectionId ?? 'anytime';
//     final habitWithSection = habit.copyWith(sectionId: sectionId);

//     final result = await addHabit(habitWithSection);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<void> update(Habit habit) async {
//     final result = await updateHabit(habit);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<void> delete(String habitId) async {
//     final result = await deleteHabit(habitId);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) {
//         final updatedHabits =
//             state.habits.where((h) => h.habit.id != habitId).toList();
//         state = state.copyWith(habits: updatedHabits);
//         watchHabits(currentDay);
//       },
//     );
//   }

//   Future<void> toggleCompletion(HabitDetails hd) async {
//     final newStatus =
//         hd.isCompletedForDay ? HabitStatus.active : HabitStatus.completed;

//     final logEntry = HabitLog(
//       id: '${hd.habit.id}_${DateTime.now().toIso8601String()}',
//       habitId: hd.habit.id,
//       date: DateTime.now(),
//       status: newStatus,
//     );

//     final result = await logHabitCompletion(logEntry);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<void> setTodayStatus(String habitId, HabitStatus status) async {
//     final today = DateTime.now();
//     final logEntry = HabitLog(
//       id: '${habitId}_${today.toIso8601String()}',
//       habitId: habitId,
//       date: today,
//       status: status,
//     );

//     final result = await logHabitCompletion(logEntry);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<void> logCompletion(HabitDetails habit) async {
//     final result = await logHabitCompletion(habit.toHabitLog());
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<List<Section>> getAllSections() async {
//     final habitSectionIds = state.habits.map((h) => h.habit.sectionId).toSet();
//     final List allIds = {...sectionIds.values, ...habitSectionIds}.toList();

//     return allIds.map((id) {
//       return Section(id: id, type: SectionType.anytime, orderIndex: 0);
//     }).toList();
//   }

//   Future<void> moveToSection(
//       String habitId, String newSectionId, int newIndex) async {
//     final result = await moveHabitToSection(
//       habitId: habitId,
//       newSectionId: newSectionId,
//       newOrderIndex: newIndex,
//     );
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   Future<void> reorder(String sectionId, List<String> orderedIds) async {
//     final result = await reorderHabitsWithinSection(
//         sectionId: sectionId, orderedHabitIds: orderedIds);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }
// }
// File: src/features/habits/application/habits_controller.dart
import 'dart:developer' as developer;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/section.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/enums/section_type.dart';
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
  }) : super(HabitsState(habits: [])) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      watchHabits(currentDay);
    });
  }

  // --- helpers for per-day logic ---
  DateTime _dayOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  bool _isCompletedOn(HabitDetails hd, DateTime day) {
    final d = _dayOnly(day);
    return hd.logs.any(
      (log) => _dayOnly(log.date) == d && log.status == HabitStatus.completed,
    );
  }
  // ----------------------------------

  void watchHabits(DateTime day) {
    currentDay = day;
    state = state.copyWith(isLoading: true, error: null);

    _currentStream = getHabitsForDay(day: day);
    _currentStream!.listen((result) {
      result.fold(
        (failure) {
          developer.log('[Controller] Failed to load habits: $failure');
          state = state.copyWith(error: failure.toString(), isLoading: false);
        },
        (habits) {
          // ✅ Filter habits that are scheduled for this day
          final scheduledHabits =
              habits.where((hd) => hd.habit.isScheduledForDay(day)).toList();

          developer.log(
              '[Controller] Loaded ${scheduledHabits.length} habits for $day');
          state = state.copyWith(habits: scheduledHabits, isLoading: false);
        },
      );
    });
  }

  Future<void> add(Habit habit) async {
    final sectionId = habit.sectionId ?? 'anytime';
    final habitWithSection = habit.copyWith(sectionId: sectionId);

    final result = await addHabit(habitWithSection);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }

  Future<void> update(Habit habit) async {
    final result = await updateHabit(habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }

  Future<void> delete(String habitId) async {
    final result = await deleteHabit(habitId);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {
        final updatedHabits =
            state.habits.where((h) => h.habit.id != habitId).toList();
        state = state.copyWith(habits: updatedHabits);
        watchHabits(currentDay);
      },
    );
  }

  /// ✅ Use per-day computed completion and log ONLY for the selected day.
  Future<void> toggleCompletion(HabitDetails hd) async {
    final day = _dayOnly(currentDay); // respect the calendar's selected day
    final completedToday = _isCompletedOn(hd, day);
    final newStatus =
        completedToday ? HabitStatus.active : HabitStatus.completed;

    final logEntry = HabitLog(
      id: '${hd.habit.id}_${day.toIso8601String()}',
      habitId: hd.habit.id,
      date: day,
      status: newStatus,
    );

    final result = await logHabitCompletion(logEntry);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }

  /// Keep this for places that explicitly set "today" (edit screen, etc.).
  Future<void> setTodayStatus(String habitId, HabitStatus status) async {
    final day = _dayOnly(DateTime.now());
    final logEntry = HabitLog(
      id: '${habitId}_${day.toIso8601String()}',
      habitId: habitId,
      date: day,
      status: status,
    );

    final result = await logHabitCompletion(logEntry);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }

  /// Align with per-day logging (uses the controller's selected day).
  Future<void> logCompletion(HabitDetails habit) async {
    final day = _dayOnly(currentDay);
    final entry = HabitLog(
      id: '${habit.habit.id}_${day.toIso8601String()}',
      habitId: habit.habit.id,
      date: day,
      status: HabitStatus.completed,
    );
    final result = await logHabitCompletion(entry);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }

  Future<List<Section>> getAllSections() async {
    final habitSectionIds = state.habits.map((h) => h.habit.sectionId).toSet();
    final List allIds = {...sectionIds.values, ...habitSectionIds}.toList();

    return allIds.map((id) {
      return Section(id: id, type: SectionType.anytime, orderIndex: 0);
    }).toList();
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
      (_) => watchHabits(currentDay),
    );
  }

  Future<void> reorder(String sectionId, List<String> orderedIds) async {
    final result = await reorderHabitsWithinSection(
        sectionId: sectionId, orderedHabitIds: orderedIds);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) => watchHabits(currentDay),
    );
  }
}
