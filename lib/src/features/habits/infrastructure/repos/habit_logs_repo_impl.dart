// File: src/features/habits/infrastructure/repositories/habit_logs_repo_impl.dart

import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/repos/habit_logs_repo.dart';
import 'package:zentry/src/features/habits/infrastructure/mappers/habit_log_mapper.dart';
import 'package:zentry/src/shared/infrastructure/utils/guard.dart';

class HabitLogsRepoImpl implements HabitLogsRepo {
  final AppDatabase db;

  HabitLogsRepoImpl(this.db);

  @override
  Future<Result<HabitLog>> upsert(HabitLog log) {
    return guard(() async {
      final row = await db.insertOrUpdateHabitLog(habitLogToCompanion(log));
      return habitLogFromRow(row);
    });
  }

  @override
  Future<Result<void>> delete(String logId) {
    return guard(() async {
      await db.deleteHabitLog(logId);
      return;
    });
  }

  @override
  Future<Result<List<HabitLog>>> getLogs({
    required String habitId,
    required DateTime from,
    required DateTime to,
  }) {
    return guard(() async {
      final rows = await db.getLogsForHabit(
        habitId: habitId,
        from: from,
        to: to,
      );
      return rows.map(habitLogFromRow).toList();
    });
  }

  @override
  Future<Result<List<HabitLog>>> getLogsForDate(DateTime date) {
    return guard(() async {
      final rows = await db.getLogsForDate(date);
      return rows.map(habitLogFromRow).toList();
    });
  }
}
