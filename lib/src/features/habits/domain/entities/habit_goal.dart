import '../enums/habit_goal_type.dart';
import '../enums/habit_goal_unit.dart';
import '../enums/habit_goal_period.dart';
import '../enums/habit_goal_record_mode.dart';

class HabitGoal {
  final GoalType type;
  final HabitGoalUnit unit;
  final HabitGoalPeriod period;
  final HabitGoalRecordMode recordMode;
  final int? targetAmount; // e.g., 30 minutes, 10 pages
  final DateTime? startDate;
  final DateTime? endDate;

  const HabitGoal({
    required this.type,
    required this.unit,
    required this.period,
    required this.recordMode,
    this.targetAmount,
    this.startDate,
    this.endDate,
  });
}
