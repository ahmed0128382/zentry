// File: src/features/habits/infrastructure/mappers/habit_log_mapper.dart
import 'package:drift/drift.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';

HabitLog habitLogFromRow(HabitLogRow row) {
  return HabitLog(
    id: row.id,
    habitId: row.habitId,
    date: row.date,
    status: HabitStatus.values.byName(row.status),
    amount: row.amount ?? 0, // ✅ always non-null in DB
  );
}

HabitLogsTableCompanion habitLogToCompanion(HabitLog log) {
  return HabitLogsTableCompanion(
    id: Value(log.id),
    habitId: Value(log.habitId),
    date: Value(log.date),
    status: Value(log.status.name),
    amount: Value(log.amount),
  );
}
