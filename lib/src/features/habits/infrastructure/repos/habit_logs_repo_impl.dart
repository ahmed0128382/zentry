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
      // ✅ Always normalize the date to day-only
      final normalized = _normalizeDate(log.date);

      // ✅ Build a stable ID: habitId + date (yyyy-mm-dd only)
      final stableId = '${log.habitId}_${normalized.toIso8601String()}';

      final row = await db.insertOrUpdateHabitLog(
        habitLogToCompanion(
          log.copyWith(
            id: stableId,
            date: normalized,
          ),
        ),
      );
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
        from: _normalizeDate(from),
        to: _normalizeDate(to),
      );
      return rows.map(habitLogFromRow).toList();
    });
  }

  @override
  Future<Result<List<HabitLog>>> getLogsForDate(DateTime date) {
    return guard(() async {
      final rows = await db.getLogsForDate(_normalizeDate(date));
      return rows.map(habitLogFromRow).toList();
    });
  }

  DateTime _normalizeDate(DateTime dt) =>
      DateTime(dt.year, dt.month, dt.day); // strip time
}
