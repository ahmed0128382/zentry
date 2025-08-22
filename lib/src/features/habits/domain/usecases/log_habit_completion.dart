import 'package:dartz/dartz.dart';
import '../entities/habit_log.dart';
import '../repos/habit_logs_repo.dart';

class LogHabitCompletion {
  final HabitLogsRepo repo;
  const LogHabitCompletion(this.repo);

  Future<Either<Exception, HabitLog>> call(HabitLog log) => repo.upsert(log);
}
