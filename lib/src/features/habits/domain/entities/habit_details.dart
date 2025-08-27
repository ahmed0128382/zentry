import 'package:equatable/equatable.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_log.dart';
import 'package:zentry/src/features/habits/domain/entities/habit_reminder.dart';
import 'package:zentry/src/features/habits/domain/enums/habit_status.dart';
import 'package:zentry/src/shared/domain/entities/habit.dart';

class HabitDetails extends Equatable {
  final Habit habit;
  final List<HabitLog> logs;
  final List<HabitReminder> reminders;
  final bool isCompletedForDay;

  const HabitDetails({
    required this.habit,
    required this.logs,
    required this.reminders,
    required this.isCompletedForDay,
  });

  // ← ADD THIS
  factory HabitDetails.fromHabit(Habit habit) {
    return HabitDetails(
      habit: habit,
      logs: const [],
      reminders: const [],
      isCompletedForDay: false,
    );
  }

  HabitDetails copyWith({
    Habit? habit,
    List<HabitLog>? logs,
    List<HabitReminder>? reminders,
    bool? isCompletedForDay,
  }) {
    return HabitDetails(
      habit: habit ?? this.habit,
      logs: logs ?? this.logs,
      reminders: reminders ?? this.reminders,
      isCompletedForDay: isCompletedForDay ?? this.isCompletedForDay,
    );
  }

  HabitLog toHabitLog({HabitStatus status = HabitStatus.completed}) {
    final logId = DateTime.now().microsecondsSinceEpoch.toString();
    return HabitLog(
      id: logId,
      habitId: habit.id,
      date: DateTime.now(),
      status: status,
    );
  }

  @override
  List<Object?> get props => [habit, logs, reminders, isCompletedForDay];
}
