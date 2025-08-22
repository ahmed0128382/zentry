import 'package:dartz/dartz.dart';
import '../entities/habit_log.dart';

abstract class HabitLogsRepo {
  Future<Either<Exception, HabitLog>> upsert(HabitLog log);
  Future<Either<Exception, void>> delete(String logId);

  /// Get logs for a habit in a date range
  Future<Either<Exception, List<HabitLog>>> getLogs({
    required String habitId,
    required DateTime from,
    required DateTime to,
  });

  /// For calendar cells
  Future<Either<Exception, List<HabitLog>>> getLogsForDate(DateTime date);
}
