import '../enums/habit_goal_type.dart';
import '../enums/habit_goal_unit.dart';
import '../enums/habit_goal_period.dart';
import '../enums/habit_goal_record_mode.dart';

class HabitGoal {
  final HabitGoalType type;
  final HabitGoalUnit unit;
  final HabitGoalPeriod period;
  final HabitGoalRecordMode recordMode;
  final int? targetAmount; // e.g., 30 minutes, 10 pages
  final DateTime? startDate;
  final DateTime? endDate;
  final List<int> repeatDays; // 1 = Monday, 7 = Sunday

  const HabitGoal({
    required this.type,
    required this.unit,
    required this.period,
    required this.recordMode,
    this.targetAmount,
    this.startDate,
    this.endDate,
    this.repeatDays = const [], // default empty = every day
  });
}
