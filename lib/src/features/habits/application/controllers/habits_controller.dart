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
// // // File: src/features/habits/application/habits_controller.dart
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

//   // --- helpers for per-day logic ---
//   DateTime _dayOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

//   bool _isCompletedOn(HabitDetails hd, DateTime day) {
//     final d = _dayOnly(day);
//     return hd.logs.any(
//       (log) => _dayOnly(log.date) == d && log.status == HabitStatus.completed,
//     );
//   }
//   // ----------------------------------

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

//   /// ✅ Use per-day computed completion and log ONLY for the selected day.
//   Future<void> toggleCompletion(HabitDetails hd) async {
//     final day = _dayOnly(currentDay); // respect the calendar's selected day
//     final completedToday = _isCompletedOn(hd, day);
//     final newStatus =
//         completedToday ? HabitStatus.active : HabitStatus.completed;

//     // Find existing log for the day if exists, or default to 0 amount
//     final existingLog = hd.logs.firstWhere(
//       (log) => _dayOnly(log.date) == day,
//       orElse: () => HabitLog(
//         id: '${hd.habit.id}_${day.toIso8601String()}',
//         habitId: hd.habit.id,
//         date: day,
//         status: HabitStatus.active,
//         amount: 0,
//       ),
//     );

//     final logEntry = HabitLog(
//       id: existingLog.id,
//       habitId: hd.habit.id,
//       date: day,
//       status: newStatus,
//       amount: existingLog.amount ?? 0, // ✅ ensure non-null
//     );

//     final result = await logHabitCompletion(logEntry);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   /// Keep this for places that explicitly set "today" (edit screen, etc.).
//   Future<void> setTodayStatus(String habitId, HabitStatus status) async {
//     final day = _dayOnly(DateTime.now());
//     final logEntry = HabitLog(
//       id: '${habitId}_${day.toIso8601String()}',
//       habitId: habitId,
//       date: day,
//       status: status,
//       amount: 0, // ✅ default 0 if not set
//     );

//     final result = await logHabitCompletion(logEntry);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   /// Align with per-day logging (uses the controller's selected day).
//   Future<void> logCompletion(HabitDetails habit) async {
//     final day = _dayOnly(currentDay);

//     final existingLog = habit.logs.firstWhere(
//       (log) => _dayOnly(log.date) == day,
//       orElse: () => HabitLog(
//         id: '${habit.habit.id}_${day.toIso8601String()}',
//         habitId: habit.habit.id,
//         date: day,
//         status: HabitStatus.active,
//         amount: 0,
//       ),
//     );

//     final entry = HabitLog(
//       id: existingLog.id,
//       habitId: habit.habit.id,
//       date: day,
//       status: HabitStatus.completed,
//       amount: existingLog.amount ?? 0, // ✅ ensure non-null
//     );
//     final result = await logHabitCompletion(entry);
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

//   // --- helpers for per-day logic ---
//   DateTime _dayOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

//   bool _isCompletedOn(HabitDetails hd, DateTime day) {
//     final d = _dayOnly(day);
//     return hd.logs.any(
//       (log) => _dayOnly(log.date) == d && log.status == HabitStatus.completed,
//     );
//   }
//   // ----------------------------------

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

//   /// ✅ Toggling now updates the specific day log, preserving amount
//   Future<void> toggleCompletion(HabitLog log) async {
//     final newStatus = log.status == HabitStatus.completed
//         ? HabitStatus.active
//         : HabitStatus.completed;

//     final updatedLog = log.copyWith(status: newStatus);

//     final result = await logHabitCompletion(updatedLog);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) {
//         // Update local state
//         final updatedHabits = state.habits.map((hd) {
//           if (hd.habit.id != log.habitId) return hd;

//           final logs = List<HabitLog>.from(hd.logs);
//           final index = logs.indexWhere((l) => l.id == log.id);
//           if (index != -1) {
//             logs[index] = updatedLog;
//           } else {
//             logs.add(updatedLog);
//           }
//           return hd.copyWith(logs: logs);
//         }).toList();

//         state = state.copyWith(habits: updatedHabits);
//       },
//     );
//   }

//   /// Keep this for places that explicitly set "today" (edit screen, etc.).
//   Future<void> setTodayStatus(String habitId, HabitStatus status) async {
//     final day = _dayOnly(DateTime.now());
//     final logEntry = HabitLog(
//       id: '${habitId}_${day.toIso8601String()}',
//       habitId: habitId,
//       date: day,
//       status: status,
//       amount: 0,
//     );

//     final result = await logHabitCompletion(logEntry);
//     result.fold(
//       (failure) => state = state.copyWith(error: failure.toString()),
//       (_) => watchHabits(currentDay),
//     );
//   }

//   /// Align with per-day logging (uses the controller's selected day).
//   Future<void> logCompletion(HabitDetails habit) async {
//     final day = _dayOnly(currentDay);

//     final existingLog = habit.logs.firstWhere(
//       (log) => _dayOnly(log.date) == day,
//       orElse: () => HabitLog(
//         id: '${habit.habit.id}_${day.toIso8601String()}',
//         habitId: habit.habit.id,
//         date: day,
//         status: HabitStatus.active,
//         amount: 0,
//       ),
//     );

//     final entry = HabitLog(
//       id: existingLog.id,
//       habitId: habit.habit.id,
//       date: day,
//       status: HabitStatus.completed,
//       amount: existingLog.amount,
//     );
//     final result = await logHabitCompletion(entry);
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
// // File: src/features/habits/application/habits_controller.dart
import 'dart:developer' as developer;
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_details.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
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

  DateTime _dayOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  bool _isCompletedOn(HabitDetails hd, DateTime day) {
    final d = _dayOnly(day);
    return hd.logs.any(
      (log) => _dayOnly(log.date) == d && log.status == HabitStatus.completed,
    );
  }

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
          // Merge old logs to avoid resetting
          final mergedHabits = habits.map((newHd) {
            final existingHd = state.habits.firstWhere(
              (hd) => hd.habit.id == newHd.habit.id,
              orElse: () => newHd,
            );

            final mergedLogs = [
              ...existingHd.logs,
              for (final log in newHd.logs)
                if (!existingHd.logs
                    .any((l) => _dayOnly(l.date) == _dayOnly(log.date)))
                  log,
            ];

            return newHd.copyWith(logs: mergedLogs);
          }).toList();

          final scheduledHabits = mergedHabits
              .where((hd) => hd.habit.isScheduledForDay(day))
              .toList();

          developer.log(
              '[Controller] Loaded ${scheduledHabits.length} habits for $day');
          state = state.copyWith(habits: scheduledHabits, isLoading: false);
        },
      );
    });
  }

  /// --- ADD habit, preserving logs for other habits ---
  Future<void> add(Habit habit,
      {List<HabitReminder> reminders = const []}) async {
    final sectionId = habit.sectionId ?? 'anytime';
    final habitWithSection = habit.copyWith(sectionId: sectionId);

    final today = _dayOnly(DateTime.now());
    final initialLog = HabitLog(
      id: '${habitWithSection.id}_${today.toIso8601String()}',
      habitId: habitWithSection.id,
      date: today,
      status: HabitStatus.active,
      amount: 0,
    );

    final newHabitDetails = HabitDetails(
      habit: habitWithSection,
      logs: [initialLog],
      reminders: reminders,
    );

    final result = await addHabit(newHabitDetails.habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {
        // merge into existing habits without overwriting logs
        state = state.copyWith(
          habits: [...state.habits, newHabitDetails],
        );
      },
    );
  }

  /// --- UPDATE habit, preserving logs ---
  Future<void> update(Habit habit,
      {List<HabitReminder> reminders = const []}) async {
    final existingHd = state.habits.firstWhere(
      (hd) => hd.habit.id == habit.id,
      orElse: () => HabitDetails(habit: habit, logs: [], reminders: reminders),
    );

    final habitDetailsWithLogs = existingHd.copyWith(
      habit: habit,
      reminders: reminders,
    );

    final result = await updateHabit(habitDetailsWithLogs.habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {
        // replace in-state habit but preserve logs
        state = state.copyWith(
          habits: state.habits.map((hd) {
            return hd.habit.id == habit.id ? habitDetailsWithLogs : hd;
          }).toList(),
        );
      },
    );
  }

  /// --- Update HabitDetails directly, preserving logs ---
  Future<void> updateDetails(HabitDetails updatedHd) async {
    state = state.copyWith(
      habits: [
        for (final hd in state.habits)
          if (hd.habit.id == updatedHd.habit.id) updatedHd else hd
      ],
    );

    final result = await updateHabit(updatedHd.habit);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {},
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
      },
    );
  }

  Future<void> updateLog(HabitLog log) async {
    final habitDetails =
        state.habits.firstWhere((hd) => hd.habit.id == log.habitId);
    final targetAmount = habitDetails.habit.goal.targetAmount ?? 0;

    int newAmount = (log.amount ?? 0) + 1;
    if (newAmount > targetAmount) newAmount = targetAmount;

    final newStatus =
        newAmount >= targetAmount ? HabitStatus.completed : HabitStatus.active;

    final updatedLog = log.copyWith(
      amount: newAmount,
      status: newStatus,
    );

    final result = await logHabitCompletion(updatedLog);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {
        final updatedHabits = state.habits.map((hd) {
          if (hd.habit.id != log.habitId) return hd;

          final logs = List<HabitLog>.from(hd.logs);
          final index =
              logs.indexWhere((l) => _dayOnly(l.date) == _dayOnly(log.date));

          if (index >= 0) {
            logs[index] = updatedLog;
          } else {
            logs.add(updatedLog);
          }

          return hd.copyWith(logs: logs);
        }).toList();

        state = state.copyWith(habits: updatedHabits);
      },
    );
  }

  Future<void> toggleCompletion(HabitLog log) async {
    await updateLog(log);
  }

  Future<void> setTodayStatus(String habitId, HabitStatus status) async {
    final day = _dayOnly(DateTime.now());
    final logEntry = HabitLog(
      id: '${habitId}_${day.toIso8601String()}',
      habitId: habitId,
      date: day,
      status: status,
      amount: 0,
    );

    final result = await logHabitCompletion(logEntry);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {},
    );

    // Update in-state logs
    final updatedHabits = state.habits.map((hd) {
      if (hd.habit.id != habitId) return hd;

      final logs = List<HabitLog>.from(hd.logs);
      final index = logs.indexWhere((l) => _dayOnly(l.date) == _dayOnly(day));

      if (index >= 0) {
        logs[index] = logEntry;
      } else {
        logs.add(logEntry);
      }

      return hd.copyWith(logs: logs);
    }).toList();

    state = state.copyWith(habits: updatedHabits);
  }

  Future<void> logCompletion(HabitDetails habit) async {
    final day = _dayOnly(currentDay);

    final existingLog = habit.logs.firstWhere(
      (log) => _dayOnly(log.date) == day,
      orElse: () => HabitLog(
        id: '${habit.habit.id}_${day.toIso8601String()}',
        habitId: habit.habit.id,
        date: day,
        status: HabitStatus.active,
        amount: 0,
      ),
    );

    final entry = HabitLog(
      id: existingLog.id,
      habitId: habit.habit.id,
      date: day,
      status: HabitStatus.completed,
      amount: existingLog.amount,
    );
    final result = await logHabitCompletion(entry);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {},
    );

    // Update in-state logs
    final updatedHabits = state.habits.map((hd) {
      if (hd.habit.id != habit.habit.id) return hd;

      final logs = List<HabitLog>.from(hd.logs);
      final index = logs.indexWhere((l) => _dayOnly(l.date) == _dayOnly(day));

      if (index >= 0) {
        logs[index] = entry;
      } else {
        logs.add(entry);
      }

      return hd.copyWith(logs: logs);
    }).toList();

    state = state.copyWith(habits: updatedHabits);
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
      (_) {},
    );

    watchHabits(currentDay);
  }

  Future<void> reorder(String sectionId, List<String> orderedIds) async {
    final result = await reorderHabitsWithinSection(
        sectionId: sectionId, orderedHabitIds: orderedIds);
    result.fold(
      (failure) => state = state.copyWith(error: failure.toString()),
      (_) {},
    );

    watchHabits(currentDay);
  }
}
