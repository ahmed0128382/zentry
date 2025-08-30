// // File: src/features/habits/application/controllers/habit_logs_controller.dart

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
// import 'package:zentry/src/features/habits/domain/repos/habit_logs_repo.dart';
// import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

// class HabitLogsController extends StateNotifier<AsyncValue<List<HabitLog>>> {
//   final HabitLogsRepo _repo;

//   HabitLogsController(this._repo) : super(const AsyncValue.loading());

//   Future<void> loadLogs({
//     required String habitId,
//     required DateTime from,
//     required DateTime to,
//   }) async {
//     state = const AsyncValue.loading();
//     final result = await _repo.getLogs(habitId: habitId, from: from, to: to);
//     state = result.fold(
//       (failure) => AsyncValue.error(failure, StackTrace.current),
//       (logs) => AsyncValue.data(logs),
//     );
//   }

//   Future<void> addOrUpdate(HabitLog log) async {
//     final result = await _repo.upsert(log);
//     result.fold(
//       (failure) => state = AsyncValue.error(failure, StackTrace.current),
//       (log) =>
//           state.whenData((logs) => state = AsyncValue.data([...logs, log])),
//     );
//   }

//   Future<void> deleteLog(String logId) async {
//     final result = await _repo.delete(logId);
//     result.fold(
//       (failure) => state = AsyncValue.error(failure, StackTrace.current),
//       (_) => state.whenData((logs) => state = AsyncValue.data(logs)),
//     );
//   }
// }

// // Provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_logs_repo.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class HabitLogsController extends StateNotifier<AsyncValue<List<HabitLog>>> {
  final HabitLogsRepo _repo;

  HabitLogsController(this._repo) : super(const AsyncValue.loading());

  Future<void> loadLogs({
    required String habitId,
    required DateTime from,
    required DateTime to,
  }) async {
    state = const AsyncValue.loading();
    final result = await _repo.getLogs(
        habitId: habitId, from: _normalize(from), to: _normalize(to));
    state = result.fold(
      (failure) => AsyncValue.error(failure, StackTrace.current),
      (logs) => AsyncValue.data(logs),
    );
  }

  Future<void> addOrUpdate(HabitLog log) async {
    final normalizedLog = log.copyWith(date: _normalize(log.date));
    final result = await _repo.upsert(normalizedLog);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (updatedLog) => state.whenData(
          (logs) => state = AsyncValue.data(_upsert(logs, updatedLog))),
    );
  }

  Future<void> deleteLog(String logId) async {
    final result = await _repo.delete(logId);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) => state.whenData((logs) =>
          state = AsyncValue.data(logs.where((l) => l.id != logId).toList())),
    );
  }

  // ----------------- Helpers -----------------
  DateTime _normalize(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  List<HabitLog> _upsert(List<HabitLog> list, HabitLog log) {
    final index = list.indexWhere((l) => l.id == log.id);
    if (index >= 0) {
      list[index] = log;
    } else {
      list.add(log);
    }
    return [...list]..sort((a, b) => a.date.compareTo(b.date));
  }
}
