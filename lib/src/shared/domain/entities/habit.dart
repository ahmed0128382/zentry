import 'package:equatable/equatable.dart';

import '../../../features/habits/domain/enums/habit_goal_type.dart';
import '../../../features/habits/domain/enums/habit_status.dart';
import '../../../features/habits/domain/enums/habit_frequency.dart';
import '../../../features/habits/domain/enums/weekday.dart';
import '../../../features/habits/domain/value_objects/weekday_mask.dart';
import '../../../features/habits/domain/entities/habit_goal.dart';
import '../../../features/habits/domain/entities/habit_log.dart';

class Habit extends Equatable {
  final String id; // UUID
  final String title;
  final String? description;
  final String? sectionId; // FK -> Section
  final HabitStatus status;
  final HabitFrequency frequency;

  /// For weekly frequency (which weekdays is the habit planned on)
  final WeekdayMask? weeklyDays;

  /// For interval frequency (e.g., every N days). Optional if not used.
  final int? intervalDays;

  final HabitGoal goal;

  /// Whether to auto open habit log UI on reminder
  final bool autoPopup;

  final DateTime createdAt;
  final DateTime updatedAt;

  const Habit({
    required this.id,
    required this.title,
    this.description,
    required this.sectionId,
    required this.status,
    required this.frequency,
    this.weeklyDays,
    this.intervalDays,
    required this.goal,
    this.autoPopup = true,
    required this.createdAt,
    required this.updatedAt,
  });

  Habit copyWith({
    String? id,
    String? title,
    String? description,
    String? sectionId,
    HabitStatus? status,
    HabitFrequency? frequency,
    WeekdayMask? weeklyDays,
    int? intervalDays,
    HabitGoal? goal,
    bool? autoPopup,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Habit(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      sectionId: sectionId ?? this.sectionId,
      status: status ?? this.status,
      frequency: frequency ?? this.frequency,
      weeklyDays: weeklyDays ?? this.weeklyDays,
      intervalDays: intervalDays ?? this.intervalDays,
      goal: goal ?? this.goal,
      autoPopup: autoPopup ?? this.autoPopup,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// ✅ Check if habit is scheduled for a given date
  bool isPlannedOnDate(DateTime dateUTC) {
    switch (frequency) {
      case HabitFrequency.daily:
        return true;
      case HabitFrequency.weekly:
        if (weeklyDays == null) return false;
        final weekday = Weekday.values[dateUTC.weekday - 1]; // Mon=1..Sun=7
        return weeklyDays!.includes(weekday);
      case HabitFrequency.monthly:
        final start = goal.startDate ?? createdAt;
        return start.day == dateUTC.day;
    }
  }

  /// ✅ Check if habit is scheduled based on interval (e.g. every N days)
  bool isPlannedByInterval(DateTime dateUTC) {
    final n = intervalDays;
    final start = goal.startDate ?? createdAt;
    if (n == null || n <= 1) return false;
    final diff = dateUTC
        .difference(DateTime.utc(start.year, start.month, start.day))
        .inDays;
    return diff >= 0 && diff % n == 0;
  }

  /// ✅ Check if goal was reached for a given day, based on logs
  bool isGoalReachedForDay(List<HabitLog> logsForThatDay) {
    switch (goal.type) {
      case HabitGoalType.achieveAll:
        return logsForThatDay.any((l) => l.status.isCompleted);
      case HabitGoalType.reachAmount:
        final target = goal.targetAmount ?? 1;
        final count = logsForThatDay.where((l) => l.status.isCompleted).length;
        return count >= target;
    }
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        sectionId,
        status,
        frequency,
        weeklyDays,
        intervalDays,
        goal,
        autoPopup,
        createdAt,
        updatedAt,
      ];
}
