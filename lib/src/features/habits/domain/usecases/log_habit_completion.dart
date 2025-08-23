import 'package:zentry/src/shared/domain/errors/result.dart';
import '../entities/habit_log.dart';
import '../repos/habit_logs_repo.dart';

class LogHabitCompletion {
  final HabitLogsRepo repo;
  const LogHabitCompletion(this.repo);

  Future<Result<HabitLog>> call(HabitLog log) => repo.upsert(log);
}
