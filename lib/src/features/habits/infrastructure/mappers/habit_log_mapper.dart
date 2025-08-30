// // File: src/features/habits/infrastructure/mappers/habit_log_mapper.dart

// import 'package:drift/drift.dart';
// import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
// import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
// import 'package:zentry/src/core/infrastucture/drift/app_database.dart';

// // --- HabitLog ---

// HabitLog habitLogFromRow(HabitLogRow row) {
//   return HabitLog(
//     id: row.id,
//     habitId: row.habitId,
//     date: row.date,
//     status: HabitStatus.values.byName(row.status), // convert string → enum
//   );
// }

// HabitLogsTableCompanion habitLogToCompanion(HabitLog log) {
//   return HabitLogsTableCompanion(
//     id: Value(log.id),
//     habitId: Value(log.habitId),
//     date: Value(log.date),
//     status: Value(log.status.name), // convert enum → string
//     amount: const Value.absent(), // optional, add if needed
//   );
// }
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
  );
}

HabitLogsTableCompanion habitLogToCompanion(HabitLog log) {
  return HabitLogsTableCompanion(
    id: Value(log.id),
    habitId: Value(log.habitId),
    date: Value(log.date),
    status: Value(log.status.name),
    amount: const Value.absent(),
  );
}
