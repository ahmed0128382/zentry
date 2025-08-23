// File: src/features/habits/domain/repos/habit_logs_repo.dart

import 'package:zentry/src/shared/infrastructure/utils/guard.dart';
import '../entities/habit_log.dart';

abstract class HabitLogsRepo {
  Future<Result<HabitLog>> upsert(HabitLog log);
  Future<Result<void>> delete(String logId);

  /// Get logs for a habit in a date range
  Future<Result<List<HabitLog>>> getLogs({
    required String habitId,
    required DateTime from,
    required DateTime to,
  });

  /// For calendar cells
  Future<Result<List<HabitLog>>> getLogsForDate(DateTime date);
}
