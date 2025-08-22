// File: src/features/habits/infrastructure/mappers/habit_mapper.dart

import 'package:drift/drift.dart';
import 'package:zentry/src/core/infrastucture/drift/app_database.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_period.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_record_mode.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_unit.dart';
import 'package:zentry/src/features/habits/domain/value_objects/weekday_mask.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_goal.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_frequency.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_goal_type.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

// --- Habit ---
// --- Habit ---
// lib/src/features/habits/data/mappers/habit_mapper.dart

Habit habitFromRow(HabitRow row) {
  return Habit(
    id: row.id,
    title: row.title,
    description: row.description,
    sectionId: row.sectionId,
    status: HabitStatus.values.firstWhere((e) => e.name == row.status),
    frequency: HabitFrequency.values.firstWhere((e) => e.name == row.frequency),
    weeklyDays: row.weeklyDaysMask != null
        ? WeekdayMask.fromInt(row.weeklyDaysMask!)
        : null,
    intervalDays: row.intervalDays,
    goal: HabitGoal(
      type: HabitGoalType.values.firstWhere((e) => e.name == row.goalType),
      unit: HabitGoalUnit.values.firstWhere((e) => e.name == row.goalUnit),
      period:
          HabitGoalPeriod.values.firstWhere((e) => e.name == row.goalPeriod),
      recordMode: HabitGoalRecordMode.values
          .firstWhere((e) => e.name == row.goalRecordMode),
      targetAmount: row.targetAmount,
      startDate: row.goalStartDate,
      endDate: row.goalEndDate,
    ),
    autoPopup: row.autoPopup,
    createdAt: row.createdAt,
    updatedAt: row.updatedAt,
  );
}

HabitsTableCompanion habitToCompanion(Habit habit) {
  return HabitsTableCompanion(
    id: Value(habit.id),
    title: Value(habit.title),
    description: Value(habit.description),
    sectionId: Value(habit.sectionId),
    status: Value(habit.status.name),
    frequency: Value(habit.frequency.name),
    weeklyDaysMask: Value(habit.weeklyDays?.toInt()),
    intervalDays: Value(habit.intervalDays),
    goalType: Value(habit.goal.type.name),
    goalUnit: Value(habit.goal.unit.name),
    goalPeriod: Value(habit.goal.period.name),
    goalRecordMode: Value(habit.goal.recordMode.name),
    targetAmount: Value(habit.goal.targetAmount),
    goalStartDate: Value(habit.goal.startDate),
    goalEndDate: Value(habit.goal.endDate),
    autoPopup: Value(habit.autoPopup),
    createdAt: Value(habit.createdAt),
    updatedAt: Value(habit.updatedAt),
  );
}

// --- HabitLog ---
HabitLog habitLogFromRow(HabitLogRow row) {
  return HabitLog(
    id: row.id,
    habitId: row.habitId,
    date: row.date,
    status: HabitStatus.values.firstWhere((e) => e.name == row.status),
  );
}

HabitLogsTableCompanion habitLogToCompanion(HabitLog log) {
  return HabitLogsTableCompanion(
    id: Value(log.id),
    habitId: Value(log.habitId),
    date: Value(log.date),
    status: Value(log.status.name),
  );
}
